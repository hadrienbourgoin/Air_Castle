class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :castle
  validates :date_begin, :date_end, presence: true
end
