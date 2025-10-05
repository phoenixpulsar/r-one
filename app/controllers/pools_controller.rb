class PoolsController < ApplicationController
  def index
    @pools = Pool.all
    @user_location = parse_location_params
    
    apply_filters!
    apply_sorting!
    
    if @user_location
      @pools = @pools.to_a.map do |pool|
        pool.define_singleton_method(:distance) do
          distance_from(@user_location[:lat], @user_location[:lng])
        end
        pool
      end
      @pools.sort_by!(&:distance) if params[:sort] == 'distance'
    end
    
    @filter_params = (params[:filters] || {}).to_h.with_indifferent_access
  end
  
  def show
    @pool = Pool.find(params[:id])
  end
  
  private
  
  def parse_location_params
    return nil unless params[:location].present?
    
    if params[:location] =~ /^([-\d.]+),([-\d.]+)$/
      { lat: $1.to_f, lng: $2.to_f }
    end
  end
  
  def apply_filters!
    filters = params[:filters] || {}
    
    @pools = @pools.with_open_stall_showers if filters[:open_stall_showers] == '1'
    @pools = @pools.with_private_showers if filters[:private_showers] == '1'
    
    @pools = @pools.yards if filters[:length_unit] == 'yards'
    @pools = @pools.meters if filters[:length_unit] == 'meters'
    
    @pools = @pools.min_lanes(filters[:min_lanes].to_i) if filters[:min_lanes].present?
    
    @pools = @pools.with_day_lockers if filters[:day_lockers] == '1'
    @pools = @pools.with_byol_lockers if filters[:byol_lockers] == '1'
    
    if filters[:membership_types].present?
      types = filters[:membership_types].reject(&:blank?)
      membership_conditions = []
      membership_conditions << "membership_type = 'public'" if types.include?('public')
      membership_conditions << "membership_type = 'private'" if types.include?('private')
      membership_conditions << "day_pass_available = true" if types.include?('day_pass')
      @pools = @pools.where(membership_conditions.join(' OR ')) if membership_conditions.any?
    end
    
    if filters[:price_min].present? && filters[:price_max].present?
      @pools = @pools.price_range(filters[:price_min].to_f, filters[:price_max].to_f)
    end
    
    @pools = @pools.with_lifeguard if filters[:lifeguard_on_duty] == '1'
    @pools = @pools.with_photos if filters[:has_photos] == '1'
    
    indoor = filters[:indoor] == '1'
    outdoor = filters[:outdoor] == '1'
    if indoor && !outdoor
      @pools = @pools.indoor
    elsif outdoor && !indoor
      @pools = @pools.outdoor
    end
    
    if filters[:date].present? && filters[:start_time].present?
      date = Date.parse(filters[:date])
      start_time = Time.parse(filters[:start_time])
      duration = (filters[:duration] || 1).to_i
      end_time = start_time + duration.hours
      
      @pools = @pools.joins(:availability_slots)
        .where(availability_slots: { 
          slot_date: date,
          available_lanes: 1..Float::INFINITY
        })
        .where('availability_slots.start_time <= ? AND availability_slots.end_time >= ?', 
               start_time, end_time)
        .distinct
    end
    
    @pools = @pools.with_pull_buoy if filters[:pull_buoy_available] == '1'
    @pools = @pools.with_kickboard if filters[:kickboard_available] == '1'
    @pools = @pools.with_fins if filters[:fins_available] == '1'
    
    @pools = @pools.with_coaches if filters[:has_coaches] == '1'
    @pools = @pools.accessible if filters[:accessible] == '1'
    @pools = @pools.masters_swimming if filters[:masters_swimming] == '1'
    @pools = @pools.with_parking if filters[:parking_available] == '1'
    @pools = @pools.paid_parking if filters[:paid_parking] == '1'
  end
  
  def apply_sorting!
    case params[:sort]
    when 'price'
      @pools = @pools.order(:price_per_hour)
    when 'earliest_slot'
      @pools = @pools.joins(:availability_slots)
        .where('availability_slots.slot_date >= ? AND availability_slots.available_lanes > 0', Date.current)
        .order('availability_slots.slot_date ASC, availability_slots.start_time ASC')
        .distinct
    when 'most_lanes'
      @pools = @pools.order(total_lanes: :desc)
    else
      @pools = @pools.order(:name)
    end
  end
end
