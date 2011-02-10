require 'test_helper'

class SubrackNamesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subrack_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subrack_name" do
    assert_difference('SubrackName.count') do
      post :create, :subrack_name => { }
    end

    assert_redirected_to subrack_name_path(assigns(:subrack_name))
  end

  test "should show subrack_name" do
    get :show, :id => subrack_names(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => subrack_names(:one).to_param
    assert_response :success
  end

  test "should update subrack_name" do
    put :update, :id => subrack_names(:one).to_param, :subrack_name => { }
    assert_redirected_to subrack_name_path(assigns(:subrack_name))
  end

  test "should destroy subrack_name" do
    assert_difference('SubrackName.count', -1) do
      delete :destroy, :id => subrack_names(:one).to_param
    end

    assert_redirected_to subrack_names_path
  end
end
