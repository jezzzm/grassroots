class Club < ActiveRecord::Base
  has_many :teams
  has_many :matches, through: :teams
end
