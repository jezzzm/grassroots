class PagesController < ApplicationController
  before_action :check_for_login, :only => [:dashboard]

  def index
    @results = Match.get_matches(dates:'results')
    @fixtures = Match.get_matches(dates: 'fixtures')
    if @current_user.present?
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
    
  end

end
