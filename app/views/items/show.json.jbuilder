json.extract! @item, :id, :user_id, :title, :notes, :done, :created_at, :updated_at
json.tags @item.tags, :id, :name
