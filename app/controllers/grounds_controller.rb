class GroundsController < ApplicationController
  def show
    @ground = Ground.find params[:id]
    # raise 'hell'Geo
    # @location = reverse_geocoded_by :latitude=> @ground.latitude, :longitude=> @ground.longitude
  end

  def index
    @grounds = Ground.all

  end

  def new
    @ground = Ground.new
  end

  def create
    @ground = Ground.create ground_params
    if @ground.save #returns true or false (i.e valid or not)
      redirect_to @ground
    else
      render :new
    end
  end
end
