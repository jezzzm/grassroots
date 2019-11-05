class GroundsController < ApplicationController
  before_action :check_for_admin, :only => [:new, :create, :edit, :update, :destroy]
  def show
    @ground = Ground.find params[:id]
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

  def edit
  end

  def update

  end

  def destroy
    ground = Ground.find params[:id]
    ground.destroy
    redirect_to grounds_path
  end
end
