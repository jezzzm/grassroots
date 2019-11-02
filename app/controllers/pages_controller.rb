class PagesController < ApplicationController
  def index
    @matches = Match.get_matches(10, 'results')
    if @current_user.present?
      #show custom dashboard
    else
      render :latest
    end

  end

  def division
    @matches = Match.get_matches(10, 'fixtures')
    if @current_user.present?
      #show custom dashboard
    else
      render :division
    end
  end
end
