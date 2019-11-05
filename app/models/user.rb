class User < ActiveRecord::Base
  has_many :favs, :dependent => :delete_all
  has_many :teams, :through=> :favs
  has_many :matches, :through=> :teams
  has_secure_password

  validates :email, :presence=> true, :uniqueness => true
end
