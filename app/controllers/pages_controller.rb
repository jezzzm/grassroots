class PagesController < ApplicationController
  before_action :check_for_login, :only => [:dashboard]

  def index
    @results = Match.get_matches(dates:'results')
    @fixtures = Match.get_matches(dates: 'fixtures')
    if @current_user.present? && @current_user.teams.present?
      redirect_to dashboard_path
    else
      render :latest
    end

  end

  def division
    @age_group = params[:age_group]
    @division = params[:division]
    @fixtures = Match.get_matches(age_group: @age_group, division: @division, dates: 'fixtures')
    @results = Match.get_matches(age_group: @age_group, division: @division, dates: 'results')
  end

  def age_group
    @age_group = params[:age_group]
    @teams = Team.where(:age_group=> @age_group)
    @divisions = @teams.pluck(:division).uniq.sort
  end

  def dashboard
      @favs = @current_user.favs
  end

  def navigator
    @teams = Team.all.order(:age_group, :division) #to get team data for display in main div
    @team = @teams.first
    @clubs = @teams.map{|t| t.club.name}.uniq.sort # to populate club dropdown
    @age_groups = @teams.pluck(:age_group).uniq.sort #to populate age_grop dd
    @divisions = @teams.pluck(:division).uniq.sort #to populdate division dd
  end

end
