class TeamExtractor < ApplicationService

  def initialize matches_with_teams
    @matches = matches_with_teams
  end

  def call #return unique collection of teams from collection of matches
    team_ids = []
    @matches.each do |m|
      t = m.teams
      team_ids << t[0] << t[1] #why cant i destructure with splat here??
    end
    team_ids.uniq.map { |id| Team.find(id) }
  end
end
