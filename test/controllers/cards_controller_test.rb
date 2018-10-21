require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest

  test "should post :create" do
    post cards_url
    assert_response :success
  end

  test "should put :update" do
    post cards_url
    assert_response :success
  end

end
