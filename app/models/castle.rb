class Castle < ApplicationRecord
  belongs_to :user
  validates :user, :name, :price, :address, :description, presence: true
end
