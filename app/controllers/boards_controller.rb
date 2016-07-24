class BoardsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    p params
    if !params["client_id"]
      render json: {error: "Client ID not specified"}, :status => 400
    else
      boards = Board.includes(:board_users).where({client_id: params["client_id"], status: "OPEN"})
      board_with_user_info = []
      boards.each do |board|
        board_json =  JSON.parse(board.to_json)
        board_json["user_details"] = []
        board.board_users.each do |board_user|
          user_info = JSON.parse(User.find(board_user[:user_id]).to_json)
          user_info.delete("password")
          board_json["user_details"].push(user_info)
        end
        board_with_user_info.push(board_json)
      end
      render json: { count: boards.count ,boards: board_with_user_info}
    end
  end

  def add_user
    board_user_info = JSON.parse(request.body.read)
    existing_board_user = BoardUser.find_by({board_id: board_user_info["board_id"], user_id: board_user_info["user_id"]})
    if existing_board_user
      render json:{}
    else
      BoardUser.create({board_id: board_user_info["board_id"], user_id: board_user_info["user_id"]})
      render json:{}
    end
  end

  def save
    board_info = JSON.parse(request.body.read)
    existing_board = Board.find_by(id: board_info["id"])
    squares = board_info["squares"]
    board_info = board_info.except("squares")
    status = "created"
    p board_info
    if existing_board
      if existing_board["rows"] == board_info["rows"] && existing_board["columns"] == board_info["columns"]
        existing_board.update(board_info)
        if squares.length > 0
          for i in 0..(board_info["rows"]-1) 
            for j in 0..(board_info["columns"]-1)
              square = existing_board.squares.find_by({board_id: existing_board["id"], i: i, j: j})
              square.update({board_id: existing_board["id"], i: i, j: j, name: squares[i][j], state: {}})
            end
          end
        end
        status = "updated"
      else
        status = "rejected"
      end
    else 
      board_info["records"] = {}
      board = Board.create(board_info)
      p board["id"]
      for i in 0..(board_info["rows"]-1) 
        for j in 0..(board_info["columns"]-1)
          board.squares.create({board_id: board["id"], i: i, j: j, name: squares[i][j], state: {}})
        end
      end
    end
    render json: {status: status}
  end

  def set_record
    board_info = JSON.parse(request.body.read)
    board = Board.find_by(id: board_info["id"])
    board.update({records: board_info["records"]})
    board.squares.update({state: {}})
    render json: {}
  end

  def get_board
    board = Board.includes(:board_users).find_by(id: params["id"])
    board_json =  JSON.parse(board.to_json)
    board_json["user_details"] = []
    board.board_users.each do |board_user|
      user_info = JSON.parse(User.find(board_user[:user_id]).to_json)
      user_info.delete("password")
      board_json["user_details"].push(user_info)
    end 
    render json: {board: board_json, squares: board.squares.all}
  end

  def update_square_state
    square_info = JSON.parse(request.body.read)
    square = Board.find_by(board_id: square_info["board_id"], name: square_info["name"])
    if square
      square.update({state: square_info["state"]})
    end
    render json: {}
  end

  def get_square_state
    square_info = JSON.parse(request.body.read)
    render json: Board.find_by(board_id: square_info["board_id"], name: square_info["name"])
  end
end
