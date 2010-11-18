require 'test_helper'

class SpansControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create span" do
    assert_difference('Span.count') do
      post :create, :span => { }
    end

    assert_redirected_to span_path(assigns(:span))
  end

  test "should show span" do
    get :show, :id => spans(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => spans(:one).to_param
    assert_response :success
  end

  test "should update span" do
    put :update, :id => spans(:one).to_param, :span => { }
    assert_redirected_to span_path(assigns(:span))
  end

  test "should destroy span" do
    assert_difference('Span.count', -1) do
      delete :destroy, :id => spans(:one).to_param
    end

    assert_redirected_to spans_path
  end
end
