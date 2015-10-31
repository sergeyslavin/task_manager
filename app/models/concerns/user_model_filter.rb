module UserModelFilter
  extend ActiveSupport::Concern
  
  included do
    scope :users_without_me, ->(user) { where.not(:id => user.id) }
  end

  def actual_tags
    (items.map(&:tags).flatten!).try(:uniq) || []
  end

  def rank_items_and_handle_search(options = {})
    items.rank(:row_order).search_by(title: options[:title], tags: options[:tags])
  end

  def set_default_role
    self.role ||= Role.find_by_name('user')
  end

  def method_missing(method_name, *args, &block)
    if method_name =~ /^is_(.+)/
      self.is?($1.chop)
    else
      super
    end
  end

  def is?(role)
    return false if self.role.nil?
    (self.role.name.eql? role)
  end

  private :set_default_role
end