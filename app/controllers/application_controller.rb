class ApplicationController < ActionController::Base
  before_action :fetch_user #applies to every case

  private
  def fetch_user
    @current_user = User.find_by :id => session[:user_id] if session[:user_id].present? #find_by instead of find solves mysterious bugs
    session[:user_id] = nil unless @current_user.present? #updates session if user is deleted, for example (doesn't return an error like 'find')
  end

  def check_for_login
    redirect_to login_path unless @current_user.present?
  end

  def check_for_admin
    redirect_to root_path unless @current_user.present? && @current_user.admin?
  end
end
