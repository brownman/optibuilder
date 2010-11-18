require 'test_helper'

class TestOrlsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_orls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_orl" do
    assert_difference('TestOrl.count') do
      post :create, :test_orl => { }
    end

    assert_redirected_to test_orl_path(assigns(:test_orl))
  end

  test "should show test_orl" do
    get :show, :id => test_orls(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => test_orls(:one).to_param
    assert_response :success
  end

  test "should update test_orl" do
    put :update, :id => test_orls(:one).to_param, :test_orl => { }
    assert_redirected_to test_orl_path(assigns(:test_orl))
  end

  test "should destroy test_orl" do
    assert_difference('TestOrl.count', -1) do
      delete :destroy, :id => test_orls(:one).to_param
    end

    assert_redirected_to test_orls_path
  end
end
