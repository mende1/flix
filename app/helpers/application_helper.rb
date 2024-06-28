module ApplicationHelper
  def render_flash_stream
    turbo_stream.update 'flashes', partial: 'layouts/flash'
  end
end
