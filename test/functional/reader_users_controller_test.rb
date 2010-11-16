require 'test_helper'

class ReaderUsersControllerTest < ActionController::TestCase
  setup do
    @reader_user = reader_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reader_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reader_user" do
    assert_difference('ReaderUser.count') do
      post :create, :reader_user => @reader_user.attributes
    end

    assert_redirected_to reader_user_path(assigns(:reader_user))
  end

  test "should show reader_user" do
    get :show, :id => @reader_user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @reader_user.to_param
    assert_response :success
  end

  test "should update reader_user" do
    put :update, :id => @reader_user.to_param, :reader_user => @reader_user.attributes
    assert_redirected_to reader_user_path(assigns(:reader_user))
  end

  test "should destroy reader_user" do
    assert_difference('ReaderUser.count', -1) do
      delete :destroy, :id => @reader_user.to_param
    end

    assert_redirected_to reader_users_path
  end
end
