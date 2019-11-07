class PagesController < ApplicationController
  before_action :check_for_login, :only => [:dashboard]

  def index
    @results = Match.results
    @fixtures = Match.fixtures
    if @current_user.present? && @current_user.teams.present?
      redirect_to dashboard_path
    else
      render :latest
    end

  end

  def division
    @age_group = params[:age_group]
    @division = params[:division]
    div_matches = Match.age_group(@age_group).division(@division)
    @fixtures = div_matches.fixtures.soonest_to_farthest
    @results = div_matches.results.recent_to_oldest
  end

  def age_group
    @age_group = params[:age_group]
    @teams = Team.in_age_group @age_group
    @divisions = @teams.pluck(:division).uniq.sort
  end

  def dashboard
      @favs = @current_user.favs
  end

  def navigator
    @teams = Team.ordered
    @team = @teams.first
    @clubs = @teams.map{|t| t.club.name}.uniq.sort # to populate club dropdown
    @age_groups = @teams.pluck(:age_group).uniq.sort #to populate age_grop dd
    @divisions = @teams.pluck(:division).uniq.sort #to populdate division dd
  end

end
