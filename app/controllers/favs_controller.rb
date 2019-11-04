class FavsController < ApplicationController
  def create
    @fav = Fav.create fav_params
    redirect_to user_path @fav.user.id
  end

  def new
    @fav = Fav.new
    @user = @current_user
    @teams = Team.all.map {|t| [t.name, t.id]}
  end

  def edit
    @user = @current_user
    @fav = Fav.find params[:fav_id]
  end

  def update
    fav = Fav.find params[:fav_id]
    fav.update fav_params
    redirect_to user_path params[:id]
  end

  def destroy
    fav = Fav.find params[:fav_id]
    fav.destroy
    redirect_to user_path params[:id]
  end

  def index
  end

  private
  def fav_params
    params.require(:fav).permit(:name, :team_id, :user_id)
  end
end
