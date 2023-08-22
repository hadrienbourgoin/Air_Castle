class Castle < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  has_many :bookings
  validates :user, :name, :price, :address, :description, presence: true
end
