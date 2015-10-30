class Item < ActiveRecord::Base
  include RankedModel

  ranks :row_order
  
  belongs_to              :user
  has_and_belongs_to_many :tags

  validates :title, :notes, presence: true

  include ItemModelFilter #include Item model concern 
end
