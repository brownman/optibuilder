require 'test_helper'

class FibersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fibers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fiber" do
    assert_difference('Fiber.count') do
      post :create, :fiber => { }
    end

    assert_redirected_to fiber_path(assigns(:fiber))
  end

  test "should show fiber" do
    get :show, :id => fibers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => fibers(:one).to_param
    assert_response :success
  end

  test "should update fiber" do
    put :update, :id => fibers(:one).to_param, :fiber => { }
    assert_redirected_to fiber_path(assigns(:fiber))
  end

  test "should destroy fiber" do
    assert_difference('Fiber.count', -1) do
      delete :destroy, :id => fibers(:one).to_param
    end

    assert_redirected_to fibers_path
  end
end
