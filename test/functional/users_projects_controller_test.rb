require 'test_helper'

class UsersProjectsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_project" do
    assert_difference('UsersProject.count') do
      post :create, :users_project => { }
    end

    assert_redirected_to users_project_path(assigns(:users_project))
  end

  test "should show users_project" do
    get :show, :id => users_projects(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => users_projects(:one).to_param
    assert_response :success
  end

  test "should update users_project" do
    put :update, :id => users_projects(:one).to_param, :users_project => { }
    assert_redirected_to users_project_path(assigns(:users_project))
  end

  test "should destroy users_project" do
    assert_difference('UsersProject.count', -1) do
      delete :destroy, :id => users_projects(:one).to_param
    end

    assert_redirected_to users_projects_path
  end
end
