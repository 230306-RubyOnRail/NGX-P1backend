require "test_helper"

class ReimbursementControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get reimbursement_update_url
    assert_response :success
  end

  test "should get destroy" do
    get reimbursement_destroy_url
    assert_response :success
  end
end
