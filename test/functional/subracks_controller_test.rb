require 'test_helper'

class SubracksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subracks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subrack" do
    assert_difference('Subrack.count') do
      post :create, :subrack => { }
    end

    assert_redirected_to subrack_path(assigns(:subrack))
  end

  test "should show subrack" do
    get :show, :id => subracks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => subracks(:one).to_param
    assert_response :success
  end

  test "should update subrack" do
    put :update, :id => subracks(:one).to_param, :subrack => { }
    assert_redirected_to subrack_path(assigns(:subrack))
  end

  test "should destroy subrack" do
    assert_difference('Subrack.count', -1) do
      delete :destroy, :id => subracks(:one).to_param
    end

    assert_redirected_to subracks_path
  end
end
