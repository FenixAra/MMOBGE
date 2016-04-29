json.array!(@squares) do |square|
  json.extract! square, :id, :name, :board_id, :state
  json.url square_url(square, format: :json)
end
