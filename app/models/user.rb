class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :password, presence: true
  # validates :password, confirmation: true
  validates :email, uniqueness: true


end
