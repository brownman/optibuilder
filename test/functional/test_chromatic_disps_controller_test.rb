require 'test_helper'

class TestChromaticDispsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_chromatic_disps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_chromatic_disp" do
    assert_difference('TestChromaticDisp.count') do
      post :create, :test_chromatic_disp => { }
    end

    assert_redirected_to test_chromatic_disp_path(assigns(:test_chromatic_disp))
  end

  test "should show test_chromatic_disp" do
    get :show, :id => test_chromatic_disps(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => test_chromatic_disps(:one).to_param
    assert_response :success
  end

  test "should update test_chromatic_disp" do
    put :update, :id => test_chromatic_disps(:one).to_param, :test_chromatic_disp => { }
    assert_redirected_to test_chromatic_disp_path(assigns(:test_chromatic_disp))
  end

  test "should destroy test_chromatic_disp" do
    assert_difference('TestChromaticDisp.count', -1) do
      delete :destroy, :id => test_chromatic_disps(:one).to_param
    end

    assert_redirected_to test_chromatic_disps_path
  end
end
