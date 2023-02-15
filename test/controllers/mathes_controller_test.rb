require "test_helper"

class MathesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mathes_new_url
    assert_response :success
  end

  test "should get create" do
    get mathes_create_url
    assert_response :success
  end

  test "should get show" do
    get mathes_show_url
    assert_response :success
  end

  test "should get destroy" do
    get mathes_destroy_url
    assert_response :success
  end
end
