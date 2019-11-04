class UsersController < ApplicationController
  before_action :check_for_login, :only => [:index]

  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    if @user.save #returns true or false (i.e valid or not)
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
    @user = @current_user
    @teams = @user.teams
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
