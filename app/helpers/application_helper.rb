module ApplicationHelper

  def title(page_title)
    content_for :title, "Tasks | " + page_title.to_s
  end

  def str_or_na(str)
    str ? str : "-"
  end

  def print_notice(notice)
    if notice
      content_tag(:div, class:'alert alert-success') do
        content_tag(:button, 'x', class:'close', :'data-dismiss'=>:'alert') + notice
      end
    end
  end

  def error_field(resource)
    if resource.errors.any?
      content_tag(:div, class:'alert alert-danger') do
        link_to("x", '#', class:'close', :'data-dismiss' => :'alert') +
        content_tag(:h3, "#{pluralize(resource.errors.count, "error")} prohibited this post from being saved:") +
        content_tag(:ul) do
          resource.errors.full_messages.each do |msg|
            concat content_tag(:li, msg)
          end
        end
      end
    end
  end

end
