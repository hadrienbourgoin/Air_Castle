class Castle < ApplicationRecord
  has_many_attached :photos, dependent: :destroy
  belongs_to :user
  has_many :bookings, dependent: :destroy
  geocoded_by :address

  validates :user, :name, :price, :address, :description, presence: true
  validates :name, length: { within: (6..30) }

  validates :photos, limit: { min: 0, max: 5 }

  after_validation :geocode, if: :will_save_change_to_address?

  include AlgoliaSearch

  algoliasearch do
    attributes :name, :address, :description
  end
end
