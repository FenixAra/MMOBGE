require 'test_helper'

class SquaresControllerTest < ActionController::TestCase
  setup do
    @square = squares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:squares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create square" do
    assert_difference('Square.count') do
      post :create, square: { board_id: @square.board_id, name: @square.name, state: @square.state }
    end

    assert_redirected_to square_path(assigns(:square))
  end

  test "should show square" do
    get :show, id: @square
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @square
    assert_response :success
  end

  test "should update square" do
    patch :update, id: @square, square: { board_id: @square.board_id, name: @square.name, state: @square.state }
    assert_redirected_to square_path(assigns(:square))
  end

  test "should destroy square" do
    assert_difference('Square.count', -1) do
      delete :destroy, id: @square
    end

    assert_redirected_to squares_path
  end
end
