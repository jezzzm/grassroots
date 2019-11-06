class MatchesController < ApplicationController
  def index
  end

  def show
    @match = Match.find params[:id]
  end

  def create
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
