json.array!(@boards) do |board|
  json.extract! board, :id, :name, :users, :rows, :column
  json.url board_url(board, format: :json)
end
