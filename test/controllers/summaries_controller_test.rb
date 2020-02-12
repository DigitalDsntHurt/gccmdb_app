require 'test_helper'

class SummariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get summaries_index_url
    assert_response :success
  end

  test "should get scratch" do
    get summaries_scratch_url
    assert_response :success
  end

end
