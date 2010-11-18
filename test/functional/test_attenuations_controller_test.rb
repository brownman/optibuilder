require 'test_helper'

class TestAttenuationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_attenuations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_attenuation" do
    assert_difference('TestAttenuation.count') do
      post :create, :test_attenuation => { }
    end

    assert_redirected_to test_attenuation_path(assigns(:test_attenuation))
  end

  test "should show test_attenuation" do
    get :show, :id => test_attenuations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => test_attenuations(:one).to_param
    assert_response :success
  end

  test "should update test_attenuation" do
    put :update, :id => test_attenuations(:one).to_param, :test_attenuation => { }
    assert_redirected_to test_attenuation_path(assigns(:test_attenuation))
  end

  test "should destroy test_attenuation" do
    assert_difference('TestAttenuation.count', -1) do
      delete :destroy, :id => test_attenuations(:one).to_param
    end

    assert_redirected_to test_attenuations_path
  end
end
