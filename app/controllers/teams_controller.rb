class TeamsController < ApplicationController
  def show
    @team = Team.find params[:id]
    @results = @team.results
    @fixtures = @team.fixtures
  end

  def matchup
    @a = Team.find params[:a]
    @b = Team.find params[:b]

    matches = Match.matchup(@a.id, @b.id)
    @next = matches.last #TODO more robust
    @last = matches.first #TODO more robust

    data = LadderCreator.call(matches)
    @a_stats = data[0][0] == @a.id ? data[0][1] : data[1][1]
    @b_stats = data[0][0] == @b.id ? data[0][1] : data[1][1]

  end

  def results
    @team = Team.find params[:id]
    @page = params[:page]
    @results = Match.team(@team).results.recent_to_oldest.page(@page)
  end

  def fixtures
    @team = Team.find params[:id]
    @page = params[:page]
    @fixtures = Match.team(@team).fixtures.soonest_to_farthest.page(@page)
  end
end
