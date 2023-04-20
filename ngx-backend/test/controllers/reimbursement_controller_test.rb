require "test_helper"

class ReimbursementControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:one)
    @user1_token = JsonWebToken.encode('user_id': @user1.id)
    @Auth_user1 = {'Authorization' => "Bearer #{@user1_token}"}


    @user2 = users(:two)
    @user2_token = JsonWebToken.encode('user_id': @user2.id)
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

  test "should be able to view their reimbursement as employee" do
    get '/reimbursement/:id', headers: @Auth_user2,as: :json
    assert_not_empty @response.body
    assert_response :success
  end

  test "should get index of all reimbursements as manager" do
    get '/reimbursement/', headers: @Auth_user1, as: :json
    assert_match "reimbursement", @response.body
    assert_not_empty(@response.body)
    assert_response :success
  end

  test "should not show index for unauthorized user" do
    get '/reimbursement/', headers:@Auth_user2, as: :json
    assert_response :unauthorized

  end

  
  # test "should be able destroy any requests as a manager" do
  #   delete '/reimbursement/:id', headers: @Auth_user1, params: {id: @reim1.id}, as: :json
  #   assert_equal "delete", @controller.action_name
  #   assert_response :success
  # end
end
