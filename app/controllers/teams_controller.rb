class TeamsController < ApplicationController
  def show
    @team = Team.find params[:id]
    @results = @team.results
    @fixtures = @team.fixtures
  end
end
