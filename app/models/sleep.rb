class Sleep < ApplicationRecord

  belongs_to :user

  validates_presence_of :start_time, :end_time
  validate :valid_time?

  private

  def valid_time?
    return if start_time.blank? || end_time.blank?
    return if start_time < end_time
    errors.add(:base, "Start Time should always be lesser than the End Time")
  end
end
