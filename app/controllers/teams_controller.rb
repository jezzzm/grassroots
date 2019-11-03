class TeamsController < ApplicationController
  def show
    #if user enters team name after age group and division (i.e AA/1/Macquarie Dragons)
    #should conduct a search for similar names in that division and present as options to choose from
    @team = Team.find params[:id]
    @results = @team.results
    @fixtures = @team.fixtures

  end
end
