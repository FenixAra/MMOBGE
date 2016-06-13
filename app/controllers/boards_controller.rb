class BoardsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    render json: { count: Board.count ,boards: Board.all}
  end

  def save
    board_info = JSON.parse(request.body.read)
    @existing_board = Board.find_by(id: board_info["id"])
    squares = board_info["squares"]
    board_info = board_info.except("squares")
    status = "created"
    p board_info
    if @existing_board
      if @existing_board["rows"] == board_info["rows"] && @existing_board["columns"] == board_info["columns"]
        @existing_board.update(board_info)
        for i in 0..(board_info["rows"]-1) 
          for j in 0..(board_info["columns"]-1)
            square = @existing_board.squares.find_by({board_id: @existing_board["id"], i: i, j: j})
            square.update({board_id: @existing_board["id"], i: i, j: j, name: squares[i][j], state: {}})
          end
        end
        status = "updated"
      else
        status = "rejected"
      end
    else 
      board_info["records"] = {}
      @board = Board.create(board_info)
      p @board["id"]
      for i in 0..(board_info["rows"]-1) 
        for j in 0..(board_info["columns"]-1)
          @board.squares.create({board_id: @board["id"], i: i, j: j, name: squares[i][j], state: {}})
        end
      end
    end
    render json: {status: status}
  end
end
