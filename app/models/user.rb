class User < ActiveRecord::Base
  has_secure_password
  has_many :songs
  has_many :adds, dependent: :destroy
  has_many :songs_added, through: :adds, source: :song
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
end
