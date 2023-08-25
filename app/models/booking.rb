class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :castle
  validates :date_begin, :date_end, presence: true
  validate :check_dates

  def check_dates
    if date_begin > date_end
      errors.add(:date_end, message: "cannot be before date begin")
    end
  end
end
