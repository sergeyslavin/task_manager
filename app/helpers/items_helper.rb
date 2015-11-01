module ItemsHelper

  def time_pretty_format(date)
    Time.at(date).localtime.strftime("%Y/%m/%d %H:%M")
  end

  def is_closed_text(done)
    done ? "Closed" : "Open"
  end

  def print_tags(tags, options = {})
    add_link = lambda{ |tag| return "<a href='#{generate_search_tag_url(tag.id)}'>#{tag.name}</a>" }
    just_name = lambda{ |tag| return tag.name }
    actual_handle = (options.has_key? :link and options[:link].eql? true) ? add_link : just_name
    (tags.empty?) ? "..." : (tags.map { |tag| actual_handle.call(tag) }.join(", ")).html_safe
  end

  def generate_search_tag_url(tag_id = nil, title = nil)
    quert_string = {
      "utf8" => "✓",
      "search" => {
        "title" => ((title.nil?) ? "" : title),
        "tags_ids" => ((tag_id.nil?) ? [] : [tag_id])
      },
      "commit" => "Search"
    }.to_param

    items_path + "?" + quert_string
  end

end
