class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :castles, dependent: :destroy
  has_many :bookings, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true, length: { within: (6..14) }

  before_create do
    self.avatar = "https://dessins-animes-hrd.appspot.com/img/dessins-animes/davidlegnome.jpg" if avatar.blank?
  end
end
