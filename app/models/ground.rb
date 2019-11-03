class Ground < ActiveRecord::Base
  has_many :matches

  # geocoded_by :address => :name
  # after_validation :geocode, :if => :address_changed?

end
