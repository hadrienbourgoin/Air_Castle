class Castle < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  validates :user, :name, :price, :address, :description, presence: true
end
