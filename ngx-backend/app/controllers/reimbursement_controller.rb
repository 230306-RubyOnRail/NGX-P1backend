
require 'logger'

# rails new <name the app>

class ReimbursementController < ApplicationController
  include Authenticatable
  def initialize
    super
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
  end

  def update
    
    # auth

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
      if record.update(sample)
        @logger.info("Successfully updated record at ID: #{sample['id']}!")
        # return {status: [201, "Created"], body: {message: 'reimbursement updated successfully'}}
        head :ok
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
      head :ok
    else
      @logger.info('Record was not in the database')
      head :ok
    end
  end

  def show 
    @logger.info("request")
    sample = JSON.parse(request.body.read)
  
    #find if reimbursement exists on the database
    record = Reimbursement.find(sample['id'])
    if record !=nil
      @logger.info("Updating record on record #{sample['id']}")
    end
    #show
    @reimbursement_list = Reimbursement.where(id:sample['id']).first

    render status: :ok , json:{reimbursement: @reimbursement_list} 
    end

  def index
    @reimbursement_list = Reimbursement.all 

    render status: :ok, json:{reimbursement: @reimbursement_list}
  end
end
