class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team", foreign_key: "home_id", :optional=> true
  belongs_to :away_team, class_name: "Team", foreign_key: "away_id", :optional=> true
  belongs_to :ground, :optional=> true

  scope :age_group, -> (age_group) {where(:age_group => age_group)}
  scope :division, -> (division) {where(:division => division)}
  scope :results, -> {where('game_date < ?', Time.now).where.not(:home_score=> nil)}
  scope :fixtures, -> {where(:home_score => nil)}
  scope :team, -> (team) {where(:away_id => team).or(where(:home_id => team))}
  scope :matchup, -> (a, b) {team(a).team(b)}
  scope :max_round, -> (round) {where('round <= ?', round)}
  scope :min_round, -> (round) {where('round >= ?', round)}
  scope :specific_round, -> (round) {where('round == ?', round)}
  scope :recent_to_oldest, -> {order(game_date: :desc)}
  scope :soonest_to_farthest, -> {order(:game_date)}


  def played? #kickoff time plus ~105minutes playing time incl breaks, estimated
    Time.now > self.game_date + 60 * 105 && self.home_score.present?
  end

  def teams
    [self.home_id, self.away_id]
  end

end
