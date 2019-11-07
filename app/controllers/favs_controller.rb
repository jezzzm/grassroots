class FavsController < ApplicationController
  before_action :check_for_login
  def create
    fav = Fav.create fav_params
    redirect_to user_path fav.user.id
  end

  def new
    @user = @current_user
    @fav = Fav.new
    hits = Team.where(:age_group => params[:age_group], :division=> params[:division])
    @results = hits.map {|t| [t.name, t.id]}

  end

  def find
    all = Team.all
    @age_groups = all.pluck(:age_group).uniq.sort
    @divisions = all.pluck(:division).uniq.sort ## only for selected age group
    @clubs = all.map{|t| t.club.name}.uniq.sort ## only for selected age group and division
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
