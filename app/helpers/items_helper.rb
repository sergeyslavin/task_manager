module ItemsHelper

  def time_pretty_format(date)
    Time.at(date).localtime.strftime("%Y/%m/%d %H:%M")
  end

  def is_closed_text(done)
    done ? "Closed" : "Open"
  end

  def print_tags(tags)
    (tags.empty?) ? "..." : (tags.map { |tag| "<a href='#'>#{tag.name}</a>" }.join(", ")).html_safe
  end

end
