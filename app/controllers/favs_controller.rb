class FavsController < ApplicationController
  def create
    @fav = Fav.create fav_params

  end

  def new
    @fav = Fav.new
    @user = @current_user
    @teams = Team.all.map {|t| [t.name, t.id]}
    # @team_names = teams.map {|t| t.name}
    # @team_ids = teams.map {|t| t.id}
    # raise 'hell'
  end

  def edit
    @user = @current_user
    @fav = Fav.find params[:fav_id]
  end

  def update
  end

  def destroy
  end

  def index
  end

  private
  def fav_params
    params.require(:fav).permit(:name, :team_id, :user_id)
  end
end
