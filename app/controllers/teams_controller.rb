class TeamsController < ApplicationController
  def show
    @team = Team.find params[:id]
    @results = @team.results
    @fixtures = @team.fixtures
  end

  def matchup
    @a = Team.find params[:a]
    @b = Team.find params[:b]
    matches = Match.get_matches(:h2h => [@a.id, @b.id])
    data = LadderCreator.call(matches)
    @a_stats = data[0][0] == @a.id ? data[0][1] : data[1][1]
    @b_stats = data[0][0] == @b.id ? data[0][1] : data[1][1]
    # raise 'he'
    @next = matches.last #TODO more robust
    @last = matches.first #TODO more robust
  end
end
