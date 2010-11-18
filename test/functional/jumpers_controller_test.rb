require 'test_helper'

class JumpersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jumpers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jumper" do
    assert_difference('Jumper.count') do
      post :create, :jumper => { }
    end

    assert_redirected_to jumper_path(assigns(:jumper))
  end

  test "should show jumper" do
    get :show, :id => jumpers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => jumpers(:one).to_param
    assert_response :success
  end

  test "should update jumper" do
    put :update, :id => jumpers(:one).to_param, :jumper => { }
    assert_redirected_to jumper_path(assigns(:jumper))
  end

  test "should destroy jumper" do
    assert_difference('Jumper.count', -1) do
      delete :destroy, :id => jumpers(:one).to_param
    end

    assert_redirected_to jumpers_path
  end
end
