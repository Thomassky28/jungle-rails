class User < ActiveRecord::Base

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true

  has_secure_password
end
