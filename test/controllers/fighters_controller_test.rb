require 'test_helper'

class FightersControllerTest < ActionController::TestCase
  setup do
    @fighter = fighters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fighters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fighter" do
    assert_difference('Fighter.count') do
      post :create, fighter: {  }
    end

    assert_redirected_to fighter_path(assigns(:fighter))
  end

  test "should show fighter" do
    get :show, id: @fighter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fighter
    assert_response :success
  end

  test "should update fighter" do
    patch :update, id: @fighter, fighter: {  }
    assert_redirected_to fighter_path(assigns(:fighter))
  end

  test "should destroy fighter" do
    assert_difference('Fighter.count', -1) do
      delete :destroy, id: @fighter
    end

    assert_redirected_to fighters_path
  end
end
