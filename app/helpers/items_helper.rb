module ItemsHelper

  def time_pretty_format(date)
    Time.at(date).localtime.strftime("%Y/%m/%d %H:%M")
  end

  def is_closed_text(done)
    done ? "Closed" : "Open"
  end

  def print_tags(tags, options = {})
    add_link = lambda{ |name| return "<a href='#'>#{name}</a>" }
    just_name = lambda{ |name| return name }
    actual_handle = (options.has_key? :link and options[:link].eql? true) ? add_link : just_name
    (tags.empty?) ? "..." : (tags.map { |tag| actual_handle.call(tag.name) }.join(", ")).html_safe
  end

end
