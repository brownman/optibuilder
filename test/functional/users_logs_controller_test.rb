require 'test_helper'

class UsersLogsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_log" do
    assert_difference('UsersLog.count') do
      post :create, :users_log => { }
    end

    assert_redirected_to users_log_path(assigns(:users_log))
  end

  test "should show users_log" do
    get :show, :id => users_logs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => users_logs(:one).to_param
    assert_response :success
  end

  test "should update users_log" do
    put :update, :id => users_logs(:one).to_param, :users_log => { }
    assert_redirected_to users_log_path(assigns(:users_log))
  end

  test "should destroy users_log" do
    assert_difference('UsersLog.count', -1) do
      delete :destroy, :id => users_logs(:one).to_param
    end

    assert_redirected_to users_logs_path
  end
end
