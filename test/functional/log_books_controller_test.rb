require 'test_helper'

class LogBooksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:log_books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create log_book" do
    assert_difference('LogBook.count') do
      post :create, :log_book => { }
    end

    assert_redirected_to log_book_path(assigns(:log_book))
  end

  test "should show log_book" do
    get :show, :id => log_books(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => log_books(:one).to_param
    assert_response :success
  end

  test "should update log_book" do
    put :update, :id => log_books(:one).to_param, :log_book => { }
    assert_redirected_to log_book_path(assigns(:log_book))
  end

  test "should destroy log_book" do
    assert_difference('LogBook.count', -1) do
      delete :destroy, :id => log_books(:one).to_param
    end

    assert_redirected_to log_books_path
  end
end
