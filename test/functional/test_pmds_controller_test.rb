require 'test_helper'

class TestPmdsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_pmds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_pmd" do
    assert_difference('TestPmd.count') do
      post :create, :test_pmd => { }
    end

    assert_redirected_to test_pmd_path(assigns(:test_pmd))
  end

  test "should show test_pmd" do
    get :show, :id => test_pmds(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => test_pmds(:one).to_param
    assert_response :success
  end

  test "should update test_pmd" do
    put :update, :id => test_pmds(:one).to_param, :test_pmd => { }
    assert_redirected_to test_pmd_path(assigns(:test_pmd))
  end

  test "should destroy test_pmd" do
    assert_difference('TestPmd.count', -1) do
      delete :destroy, :id => test_pmds(:one).to_param
    end

    assert_redirected_to test_pmds_path
  end
end
