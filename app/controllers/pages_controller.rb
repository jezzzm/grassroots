class PagesController < ApplicationController
  def index
    @matches = Match.get_latest(10)
    if @current_user.present?
      #show custom dashboard
    else
      render :latest
    end

  end
end
