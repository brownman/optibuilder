require 'test_helper'

class TestOtdrsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_otdrs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_otdr" do
    assert_difference('TestOtdr.count') do
      post :create, :test_otdr => { }
    end

    assert_redirected_to test_otdr_path(assigns(:test_otdr))
  end

  test "should show test_otdr" do
    get :show, :id => test_otdrs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => test_otdrs(:one).to_param
    assert_response :success
  end

  test "should update test_otdr" do
    put :update, :id => test_otdrs(:one).to_param, :test_otdr => { }
    assert_redirected_to test_otdr_path(assigns(:test_otdr))
  end

  test "should destroy test_otdr" do
    assert_difference('TestOtdr.count', -1) do
      delete :destroy, :id => test_otdrs(:one).to_param
    end

    assert_redirected_to test_otdrs_path
  end
end
