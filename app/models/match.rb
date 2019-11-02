class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team", foreign_key: "home_id", :optional=> true
  belongs_to :away_team, class_name: "Team", foreign_key: "away_id", :optional=> true
  belongs_to :ground, :optional=> true
  # has_many :teams

  def self.get_matches(n, dates='all')
    if dates == 'fixtures' #only unplayed games, soonest to farthest awau
      self.where('game_date > ?', Time.now).order(:game_date).limit(n)
    elsif dates == 'results' #only played games, most recent to oldest
      self.where('game_date < ?', Time.now).order(game_date: :desc).limit(n)
    else
      self.order(game_date: :desc).limit(n) #default return all
    end
  end

  def played? #kickoff time plus ~105minutes playing time incl breaks, estimated
    Time.now > self.game_date + 60 * 105 && self.home_score.present?
  end


end
