module ApplicationHelper
  def render_flash_stream
    turbo_stream.update 'flashes', partial: 'layouts/flash'
  end

  def nav_link_to(text, url)
    link_to text, url, class: "#{current_page?(url) && 'active'}"
  end
end
