class ApplicationController < ActionController::Base

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user, :current_user?

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to sign_in_url, alert: "Please, sign in first!"
    end
  end

  def require_admin
    unless current_user.admin?
      redirect_to movies_url, alert: "Unauthorized access!"
    end
  end
end
