class AvailabilitySlot < ApplicationRecord
  belongs_to :pool
  
  validates :slot_date, presence: true
  validates :start_time, :end_time, presence: true
  validates :available_lanes, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :end_time_after_start_time
  
  private
  
  def end_time_after_start_time
    return unless start_time && end_time
    
    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end
end
