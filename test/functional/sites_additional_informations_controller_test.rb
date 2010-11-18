require 'test_helper'

class SitesAdditionalInformationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites_additional_informations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sites_additional_information" do
    assert_difference('SitesAdditionalInformation.count') do
      post :create, :sites_additional_information => { }
    end

    assert_redirected_to sites_additional_information_path(assigns(:sites_additional_information))
  end

  test "should show sites_additional_information" do
    get :show, :id => sites_additional_informations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sites_additional_informations(:one).to_param
    assert_response :success
  end

  test "should update sites_additional_information" do
    put :update, :id => sites_additional_informations(:one).to_param, :sites_additional_information => { }
    assert_redirected_to sites_additional_information_path(assigns(:sites_additional_information))
  end

  test "should destroy sites_additional_information" do
    assert_difference('SitesAdditionalInformation.count', -1) do
      delete :destroy, :id => sites_additional_informations(:one).to_param
    end

    assert_redirected_to sites_additional_informations_path
  end
end
