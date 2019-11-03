class PagesController < ApplicationController
  def index
    @results = Match.get_matches(dates:'results')
    @fixtures = Match.get_matches(dates: 'fixtures')
    if @current_user.present?
      #show custom dashboard
    else
      render :latest
    end

  end

  def division
    @age_group = params[:age_group]
    @division = params[:division]
    @fixtures = Match.get_matches(age_group: @age_group, division: @division, dates: 'fixtures')
    @results = Match.get_matches(age_group: @age_group, division: @division, dates: 'results')

    if @current_user.present?
      #show custom dashboard
    else
      render :division
    end
  end

  def age_group
    @age_group = params[:age_group]
    @teams = Team.where(:age_group=> @age_group)
    @divisions = @teams.pluck(:division).uniq.sort
  end

  def dashboard
    if @current_user.present?
      @teams = @current_user.teams
    else
      redirect_to(login_path)
    end

    # raise "hell"
  end

end
