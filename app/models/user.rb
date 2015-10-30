class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise    :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable

  has_many  :items, dependent: :destroy


  def actual_tags
    items.map(&:tags).flatten!
  end

  def rank_items(options = {})
    items.rank(:row_order).search_by(title: options[:title], tags: options[:tags])
  end
  
end
