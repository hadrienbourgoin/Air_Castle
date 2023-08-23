class Castle < ApplicationRecord
  has_many_attached :photos, dependent: :destroy
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :user, :name, :price, :address, :description, presence: true
end
