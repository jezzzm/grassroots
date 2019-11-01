class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team", foreign_key: "home_id", :optional=> true
  belongs_to :away_team, class_name: "Team", foreign_key: "away_id", :optional=> true
  belongs_to :ground, :optional=> true
  # has_many :teams
end
