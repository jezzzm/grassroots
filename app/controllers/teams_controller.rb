class TeamsController < ApplicationController
  before_action :check_for_admin, :only => [:edit, :update, :destroy, :new]
  
  def show
    @team = Team.find params[:id]
    @results = @team.results
    @fixtures = @team.fixtures
  end

  def matchup
    @a = Team.find params[:a]
    @b = Team.find params[:b]

    matches = Match.matchup(@a.id, @b.id)
    @next = matches.fixtures.soonest_to_farthest.first
    @last = matches.results.recent_to_oldest.first

    if @last.present?
      data = LadderCreator.call(matches.results)
      @a_stats = data[0][0][0] == @a.id ? data[0][0][1] : data[1][1][1]
      @b_stats = data[0][0][0] == @b.id ? data[0][0][1] : data[1][1][1]
    else
      teams = TeamExtractor.call(matches)
      data = StatScaffold.call(teams)
      @a_stats = data[params[:a].to_i]
      @b_stats = data[params[:b].to_i]
    end

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
