require 'test_helper'

class PeerRatingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:peer_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create peer_rating" do
    assert_difference('PeerRating.count') do
      post :create, :peer_rating => { }
    end

    assert_redirected_to peer_rating_path(assigns(:peer_rating))
  end

  test "should show peer_rating" do
    get :show, :id => peer_ratings(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => peer_ratings(:one).id
    assert_response :success
  end

  test "should update peer_rating" do
    put :update, :id => peer_ratings(:one).id, :peer_rating => { }
    assert_redirected_to peer_rating_path(assigns(:peer_rating))
  end

  test "should destroy peer_rating" do
    assert_difference('PeerRating.count', -1) do
      delete :destroy, :id => peer_ratings(:one).id
    end

    assert_redirected_to peer_ratings_path
  end
end
