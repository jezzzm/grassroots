class UsersController < ApplicationController
  before_action :check_for_admin, :only => [:index]
  before_action :check_for_login, :only => [:show, :edit, :update, :destroy]


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
    @user = User.find params[:id] #in case admin is modifying another user, we call params again
  end

  def update
    user = User.find params[:id]
    user.update user_params
    redirect_to user_path user
  end

  def show
    if @current_user.present?
      @user = @current_user
      @favs = @user.favs
    else
      redirect_to login_path
    end
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
