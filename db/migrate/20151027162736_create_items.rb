class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :title
      t.text :notes
      t.boolean :done

      t.timestamps null: false
    end
  end
end
