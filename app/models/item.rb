class Item < ActiveRecord::Base
  include RankedModel
  ranks :row_order
  
  belongs_to              :user
  has_and_belongs_to_many :tags

  validates :title, :notes, presence: true

  def self.search_by(options = {})
    search_by_title_result = (options[:title].nil?) ? all : self.search_by_title(options[:title])
    search_by_title_result = self.find_by_tags(search_by_title_result, options[:tags]) if !options[:tags].empty?
    search_by_title_result
  end

  def self.search_by_title(title)
    where("title LIKE ?", "%#{title}%")
  end

  def self.find_by_tags(search_by_title_result, tag_ids)
    search_by_title_result.select { |item| (item.tags.ids & tag_ids).any? }
  end

end
