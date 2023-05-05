class ReservationCriteria < ApplicationRecord
  validates :time_period, presence: true
  validates :others_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :min_time_period, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :max_guest, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end