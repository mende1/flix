module ApplicationHelper
  def show_errors_for(object, field)
    if object.errors[field].any?
      content_tag(:div, class: 'error_message') do
        "#{field.to_s.humanize} #{object.errors[field.to_sym].join(', ')}"
      end
    end
  end
end
