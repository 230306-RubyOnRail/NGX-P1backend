require "test_helper"

class ReimbursementControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:one)
    @user1_token = JSONWebToken.encode('user_id': @user1.id)
    @Auth_user1 = {'Authorization' => "Bearer #{@user1_token}"}


    @user2 = users(:two)
    @user2_token = JSONWebToken.encode('user_id': @user2.id)
    @Auth_user2 = {'Authorization' => "Bearer #{@user2_token}"}

    @reim1 = reimbursements(:gas_mileage)
  end

  test "should be true" do
    assert true
  end

  test "should be able to update status as manager" do
    put '/reimbursement/:id', headers: @Auth_user1, params: {id: @reim1.id, status: "reviewed23"}, as: :json
    assert_equal "update", @controller.action_name
    assert_response :success
  end

  test "should not be able to update status as employee" do
    put '/reimbursement/:id', headers: @Auth_user2, params: {id: @reim1.id, status: "reviewed23"}, as: :json
    assert_equal "update", @controller.action_name
    assert_response :unauthorized
  end

  
  # test "should be able destroy any requests as a manager" do
  #   get reimbursement_destroy_url
  #   assert_response :success
  # end
end
