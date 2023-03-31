class ReimbursementController < ApplicationController
  def update
    #find if reimbursement exists on the database
    record = Reimbursement.find(request.body['reimb_id'])
    
    #check if the record from the db is empty
    #if it is empty then give it an empty string
    db_record = ""
    db_record = record[0][:reimb_id] unless record.empty?
    
    #update the date
    date = Time.now.getutc
    @request[:body]['reimb_update_date'] = "#{date}"

    #need to update if I find the id
    if db_record.to_s == @request[:body]['reimb_id'].to_s 
      reimburse = Reimbursement.new(@request[:body])
      
      # if i am able to update the record
      if reimburse.update(db_record.to_s,@request[:body])
        # @logger.info("updating reimbursement")
        return {status: [201, "Created"], body: {message: 'reimbursement updated successfully'}}
      else
        return {status: [422, "Unprocessable Entity"], body: {message: 'Invalid email or password'}}
      end
    else
      #cannot find
      return {status: [204, "No Content"]}
    end
  end

  def destroy
  end
end
