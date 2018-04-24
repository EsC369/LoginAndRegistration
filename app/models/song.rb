class Song < ActiveRecord::Base
  belongs_to :user
  has_many :adds, dependent: :destroy
  has_many :users_added, through: :adds, source: :user
  validates :name, :description, presence: true
  validates :name, length: {minimum: 2}
  validates :description, length: {minimum: 2}
end
