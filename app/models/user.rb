class User < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :matches, through: :teams
  has_secure_password

  validates :email, :presence=> true, :uniqueness => true
end
