class Match < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team", foreign_key: "home_id", :optional=> true
  belongs_to :away_team, class_name: "Team", foreign_key: "away_id", :optional=> true
  belongs_to :ground, :optional=> true
  # has_many :teams

  def self.get_matches age_group: false, division: false, dates: 'all', n: 0, team:false
    if dates == 'fixtures' #only unplayed games, soonest to farthest awau
      res = self.where(:home_score=> nil).order(:game_date)
    elsif dates == 'results' #only played games, most recent to oldest
      res = self.where('game_date < ?', Time.now).where.not(:home_score=> nil).order(game_date: :desc)
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

  # def unique_teams_in_matches
  #   team_ids = []
  #   self.each do |m|
  #     team_ids << m.teams
  #     return *t
  #   end
  #   team_ids.uniq.map {|id| Team.find(id)}
  # end

  # def build_ladder #from set of matches, match class??
  #   teams = self.unique_teams_in_matches
  #   teams = Hash[teams.collect { |t| #new hash with team_ids as keys, values are hash with keys set to zero
  #      [
  #        t.id, #team_id
  #        {
  #         :name=> t.name,
  #         :mp => 0, #matches played
  #         :w => 0, #wins
  #         :d => 0, #draws
  #         :l => 0, #losses
  #         :gf => 0, #goals for
  #         :ga => 0, #goals against
  #         :gd => 0, #goal difference
  #         :pts => 0, #points (3 for win, 1 for draw, 0 for loss)
  #       }
  #     ]
  #   }]
  #
  #   self.each do |m|
  #     if m.home_score == m.away_score #draw
  #
  #       teams[m.home_id][:d] += 1
  #       teams[m.home_id][:pts] += 1
  #
  #       teams[m.away_id][:d] += 1
  #       teams[m.away_id][:pts] += 1
  #
  #     elsif m.home_score > m.away_score #home win
  #       teams[m.home_id][:w] += 1
  #       teams[m.home_id][:pts] += 3
  #
  #       teams[m.away_id][:l] += 1
  #
  #     else #away win
  #       teams[m.home_id][:l] += 1
  #
  #       teams[m.away_id][:w] += 1
  #       teams[m.away_id][:pts] += 3
  #     end
  #
  #     teams[m.home_id][:mp] += 1
  #     teams[m.home_id][:gf] += m.home_score
  #     teams[m.home_id][:ga] += m.away_score
  #     teams[m.home_id][:gd] = teams[m.home_id][:gf] - teams[m.home_id][:ga]
  #
  #     teams[m.away_id][:mp] += 1
  #     teams[m.away_id][:gf] += m.away_score
  #     teams[m.away_id][:ga] += m.home_score
  #     teams[m.away_id][:gd] = teams[m.away_id][:gf] - teams[m.away_id][:ga]
  #
  #   end
  #   teams.sort_by {|id, team| [team[:pts]*-1, team[:gd]*-1, team[:gf]*-1, team[:gc]]} #https://codereview.stackexchange.com/questions/52062/a-ruby-sorting-program-for-multiple-criteria
  # end


end
