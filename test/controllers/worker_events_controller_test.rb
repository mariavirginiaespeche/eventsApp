require "test_helper"

class WorkerEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get worker_events_index_url
    assert_response :success
  end
end
