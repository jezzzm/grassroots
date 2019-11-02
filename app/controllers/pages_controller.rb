class PagesController < ApplicationController
  def index
    @results = Match.get_matches(false, false, false, 'results')
    @fixtures = Match.get_matches(false, false, false, 'fixtures')
    if @current_user.present?
      #show custom dashboard
    else
      render :latest
    end

  end

  def division
    @age_group = params[:age_group]
    @division = params[:division]
    @fixtures = Match.get_matches(@age_group, @division, false, 'fixtures')
    @results = Match.get_matches(@age_group, @division, false, 'results')

    if @current_user.present?
      #show custom dashboard
    else
      render :division
    end
  end

end
