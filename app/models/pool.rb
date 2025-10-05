class Pool < ApplicationRecord
  has_many :availability_slots, dependent: :destroy
  has_many_attached :photos
  
  validates :name, presence: true
  validates :address, :city, :state, :zip_code, presence: true
  validates :latitude, :longitude, presence: true, numericality: true
  validates :length_value, presence: true, numericality: { greater_than: 0 }
  validates :length_unit, inclusion: { in: %w[yards meters] }
  validates :total_lanes, presence: true, numericality: { greater_than: 0 }
  validates :price_per_hour, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  
  scope :with_open_stall_showers, -> { where(open_stall_showers: true) }
  scope :with_private_showers, -> { where(private_showers: true) }
  scope :yards, -> { where(length_unit: 'yards') }
  scope :meters, -> { where(length_unit: 'meters') }
  scope :min_lanes, ->(count) { where('total_lanes >= ?', count) }
  scope :with_day_lockers, -> { where(day_lockers: true) }
  scope :with_byol_lockers, -> { where(byol_lockers: true) }
  scope :public_access, -> { where(membership_type: 'public') }
  scope :private_access, -> { where(membership_type: 'private') }
  scope :day_pass, -> { where(day_pass_available: true) }
  scope :price_range, ->(min, max) { where(price_per_hour: min..max) }
  scope :with_lifeguard, -> { where(lifeguard_on_duty: true) }
  scope :with_photos, -> { where(has_photos: true) }
  scope :indoor, -> { where(indoor: true) }
  scope :outdoor, -> { where(outdoor: true) }
  scope :with_pull_buoy, -> { where(pull_buoy_available: true) }
  scope :with_kickboard, -> { where(kickboard_available: true) }
  scope :with_fins, -> { where(fins_available: true) }
  scope :with_coaches, -> { where(has_coaches: true) }
  scope :accessible, -> { where(accessible: true) }
  scope :masters_swimming, -> { where(masters_swimming: true) }
  scope :with_parking, -> { where(parking_available: true) }
  scope :paid_parking, -> { where(paid_parking: true) }
  scope :verified, -> { where(verified: true) }
  
  def distance_from(lat, lng)
    return nil unless latitude && longitude && lat && lng
    
    rad_per_deg = Math::PI / 180
    rkm = 6371
    
    dlat_rad = (lat - latitude) * rad_per_deg
    dlon_rad = (lng - longitude) * rad_per_deg
    
    lat1_rad = latitude * rad_per_deg
    lat2_rad = lat * rad_per_deg
    
    a = Math.sin(dlat_rad / 2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad / 2)**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    
    (rkm * c * 0.621371).round(2)
  end
  
  def next_available_slot(after: Time.current)
    availability_slots
      .where('slot_date >= ? AND available_lanes > 0', after.to_date)
      .order(:slot_date, :start_time)
      .first
  end
end
