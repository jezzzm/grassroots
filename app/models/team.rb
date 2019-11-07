class Team < ActiveRecord::Base
  belongs_to :club, :optional => true
  has_many :favs, :dependent => :delete_all
  has_many :users, :through => :favs

  scope :ordered, -> {includes(:club).order('clubs.name', :age_group, :division)}
  scope :in_age_group, -> (age_group) {where(:age_group => age_group)}
  scope :in_division, -> (age_group, division) {where(:age_group => age_group, :division => division)}

  #INSTANCE METHODS
  def matches   # method to replace "has_many :matches"
    Match.team(self.id)
  end

  def results
    self.matches.results.recent_to_oldest
  end

  def fixtures
    self.matches.fixtures.soonest_to_farthest
  end

  def home_matches
    Match.where(:home_id => self.id)
  end

  def away_matches
    Match.where(:away_id => self.id)
  end

  def name #to simply get the team name + identifier (e.g. "blue"), if it exists as string
    "#{self.club.name}#{" " + self.identifier if self.identifier.present?}"
  end


  def ladder_position
    matches = Match.age_group(self.age_group).division(self.division).results
    ladder = LadderCreator.call(matches)
    ladder.index( ladder.detect { |id, hash| self.id == id } ) + 1
  end

  def form(n = 5) # return [ ['W', match_id], ['L', match_id], etc x n]
    matches = self.results.order(:game_date => :desc).limit(n).pluck(:id)
    matches.map! {|match_id| [match_id, ResultGetter.call(match_id, self.id)]}.reverse!
  end

  #CLASS METHODS
  def self.comp_teams(age_group, division)
    self.where(:age_group => age_group, :division => division)
  end

end
