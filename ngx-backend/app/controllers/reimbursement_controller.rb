require 'logger'

# rails new <name the app>

class ReimbursementController < ApplicationController
  def initialize
    super
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
  end
  def update
    
    @logger.info('Finding record...')

    sample = JSON.parse(request.body.read)
    
    #find if reimbursement exists on the database
    record = Reimbursement.find(sample['id'])
    if record !=nil
      @logger.info("Updating record on record #{sample['id']}")

      #update the time stamp
      date = Time.now.getutc
      sample.merge!({'updated_at'=> date})

      #Update the record if possible
      if record.update(sample['id'], sample)
        @logger.info("Successfully updated record at ID: #{sample['id']}!")
        return {status: [201, "Created"], body: {message: 'reimbursement updated successfully'}}
      else
        @logger.info("Failed to update record at ID: #{sample['id']}!")
        return {status: [422, "Unprocessable Entity"], body: {message: 'Invalid email or password'}}
      end


    else
      @logger.info("Cannot find record")
      return {status: [204, "No Content"]}
    end
  end

  def destroy
    
    @logger.info('Finding record...')

    sample = JSON.parse(request.body.read)
    
    #find if reimbursement exists on the database
    record = Reimbursement.find(sample['id'])

    if record != nil
      #delete record
      @logger.info('Found record, deleting record...')
      record.delete
      @logger.info('Deleted record!')
      return {status: [200, 'OK'], body: "Successfully deleted content"}
    else
      @logger.info('Record was not in the database')
      return {status: [200, "OK"], body: "Successfully deleted content"}
    end
  end
end
