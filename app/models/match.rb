class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team", foreign_key: "home_id", :optional=> true
  belongs_to :away_team, class_name: "Team", foreign_key: "away_id", :optional=> true
  belongs_to :ground, :optional=> true
  # has_many :teams

  def self.get_matches(age_group=false, division=false, team=false, dates='all', n=0)
    if dates == 'fixtures' #only unplayed games, soonest to farthest awau
      res = self.where('game_date > ?', Time.now).order(:game_date)
    elsif dates == 'results' #only played games, most recent to oldest
      res = self.where('game_date < ?', Time.now).order(game_date: :desc)
    else
      res = self.order(game_date: :desc) #default return all
    end

    res.where!(:age_group => age_group) if age_group
    res.where!(:division => division) if division
    res = res.select {|m| m.teams.include?(team)} if team
    res.limit!(n) unless n.zero?

    res
  end

  def played? #kickoff time plus ~105minutes playing time incl breaks, estimated
    Time.now > self.game_date + 60 * 105 && self.home_score.present?
  end

  def teams
    [self.home_id, self.away_id]
  end


end
