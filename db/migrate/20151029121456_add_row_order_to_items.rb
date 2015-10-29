class AddRowOrderToItems < ActiveRecord::Migration
  def change
    add_column :items, :row_order, :integer
  end
end
