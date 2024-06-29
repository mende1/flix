module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def render_flash_stream
    turbo_stream.update 'flashes', partial: 'layouts/flash'
  end
end
