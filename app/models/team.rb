class Team < ActiveRecord::Base
  belongs_to :club, :optional => true
  has_and_belongs_to_many :users

  # method to replace "has_many :matches"
  # we use this to return result if team is either home or away
  def matches
    Match.where(:home_id => self.id).or(Match.where(:away_id => self.id))
  end

  def home_matches
    Match.where(:home_id => self.id)
  end

  def away_matches
    Match.where(:away_id => self.id)
  end
end
