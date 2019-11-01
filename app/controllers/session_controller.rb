class SessionController < ApplicationController
  def new
  end

  def create
    #retrieve user
    user = User.find_by :email => params[:email]
    #check if encrypted passwords match
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id #remember the user from this moment on, just the id, everything else comes from db
      redirect_to root_path
    else
      flash[:error] = "Invalid email address or password" # only this page and one more
      redirect_to login_path # instead of render because we don't want it to be too easy to log in for a hacker
    end
    #redirect somewhere based on result of check
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path #in case they want to log in as another user
  end
end
