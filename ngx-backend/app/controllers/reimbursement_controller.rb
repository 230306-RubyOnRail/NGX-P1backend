
require 'logger'

# rails new <name the app>

class ReimbursementController < ApplicationController
  include Authenticatable
  def initialize
    super
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
  end


  # EMPLOYEE is authorized to submit a request
  def create
    if @current_user['manager'] == false || 'null'
      @logger.info("creating a new reimburement")

      sample = JSON.parse(request.body.read)

      @logger.info("Checking Authorization")
      # user = User.where(sample['user_id'])
      # if(!user.)

      date = Time.now.getutc
      sample.merge!({updated_at: date})

      @logger.info("Attempting to save reimburement")
      record = Reimbursement.new(sample)
      if record.save
        @logger.info("Successfully created a new reimburement")
        render json: { reimbursement: record}, status: :created
      else
        @logger.info("There was a problem creating a new reimburement")
        render json: record.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "You are not authorized to access this resource." }, status: :unauthorized
    end
  end

  # EMPLOYEE is allowed to update THEIR requests
  # MANAGER is allowed to update EVERYONE's STATUS requests
  def update
    
    # authenticate
    # find role
    
    @logger.info('Finding record to update...')

    sample = JSON.parse(request.body.read)
    
    if sample['status'] != nil
      #check if the client is changing the status
      if !current_user.manager
        return head :unauthorized
      end
    end
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
        head :unprocessable_entity, body: {message: 'Invalid email or password'}
      end


    else
      @logger.info("Cannot find record")
      head :no_content
    end
  end

  # EMPLOYEE is allowed to delete THIER request
  # MANAGER is allowed to delete ANY request
  def destroy
    
    @logger.info('Finding record to destroy...')

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

  # EMPLOYEE is allowed to see THIER reimburesments
  def show
    if current_user.manager == false || 'null'
      @logger.info("Parsing request at show")
      
      @logger.info("parsed request")
      #find if reimbursement exists on the database
      record = Reimbursement.where(user_id: current_user.id)
      if record !=nil
        @logger.info("Showing record on record #{current_user.id}")
        #show
        render status: :ok , json:{reimbursement: record}
      end
    else
      render json: { error: "You are not authorized to access this resource." }, status: :unauthorized
    end
  end

  # MANAGER is allowed to see ALL reimburements
  def index
    if current_user.manager
      @reimbursement_list = Reimbursement.all
      render status: :ok, json:{reimbursement: @reimbursement_list}
    else
      render json: { error: "You are not authorized to access this resource." }, status: :unauthorized
    end
  end
end
