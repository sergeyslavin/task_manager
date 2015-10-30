module ItemModelFilter
  extend ActiveSupport::Concern

  class_methods do
    def search_by(options = {})
      search_by_title_result = (options[:title].nil?) ? all : self.search_by_title(options[:title])
      search_by_title_result = self.find_by_tags(search_by_title_result, options[:tags]) if !options[:tags].empty?
      search_by_title_result
    end

    def search_by_title(title)
      where("title LIKE ?", "%#{title}%")
    end

    def find_by_tags(search_by_title_result, tag_ids)
      search_by_title_result.select { |item| (item.tags.ids & tag_ids).any? }
    end
  end
end