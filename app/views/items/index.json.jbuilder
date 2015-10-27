json.array!(@items) do |item|
  json.extract! item, :id, :user_id, :title, :notes, :done
  json.url item_url(item, format: :json)
end
