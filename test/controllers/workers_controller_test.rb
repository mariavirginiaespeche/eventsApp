require "test_helper"

class WorkersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get workers_index_url
    assert_response :success
  end

  test "should get new" do
    get workers_new_url
    assert_response :success
  end

  test "should get create" do
    get workers_create_url
    assert_response :success
  end

  test "should get show" do
    get workers_show_url
    assert_response :success
  end
end
