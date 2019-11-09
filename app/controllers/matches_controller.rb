class MatchesController < ApplicationController
  before_action :check_for_admin, :only => [:edit, :update, :destroy, :new, :create]
  def index
    redirect_to navigator_path
  end

  def show
    @match = Match.find params[:id]
  end

  def create
    match = Match.create match_params
    redirect_to match
  end

  def new
    @match = Match.new
    @grounds = Ground.pluck(:name, :id)
    @age_groups = Match.pluck(:age_group)
    @divisions = Match.pluck(:division)
    @teams = Team.ordered.pluck('clubs.name', :id)
  end

  def edit
    @match = Match.find params[:id]
    @grounds = Ground.pluck(:name, :id)
    @age_groups = Match.pluck(:age_group)
    @divisions = Match.pluck(:division)
    @teams = Team.ordered.pluck('clubs.name', :id)

  end

  def update
    match = Match.find params[:id]
    match.update match_params
    redirect_to match_path match
  end

  def destroy
    match = Match.find params[:id]
    match.destroy
    redirect_to root_path
  end

  private

  def match_params
    params.require(:match).permit(:round, :ground_id, :game_date, :home_score, :home_id, :away_score, :away_id, :comments, :age_group, :division)
  end
end
