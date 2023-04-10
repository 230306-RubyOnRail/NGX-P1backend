require 'logger'
require_relative './concerns/json_web_token'
class UserController < ApplicationController
  include Authenticatable
  def initialize
    super
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
  end

<<<<<<< HEAD
  skip_before_action :verify_authenticity_token

  # MANAGERS can create new users
=======
  def index
    @users = User.all
    @logger.info("View all users")
    render json: { user: @users }, status: :ok
  end
>>>>>>> bbffbd348369f0e36abdfe218150cb3f263beef1
  def create
    if @current_user['manager'] == true
    # if UsersPolicy.allowed?(current_user)
      user = User.new(JSON.parse(request.body.read))
      if user.save
        @logger.info("User successfully created")
        render json: user, status: :created
      else
        @logger.info("User creation unsuccessful")
        render json: user.errors, status: :unprocessable_entity
      end
    else
<<<<<<< HEAD
      @logger.info("There was and error logging in")
      render json: user.errors, status: :unprocessable_entity
=======
      render json: { error: "You are not authorized to access this resource." }, status: :unauthorized
>>>>>>> bbffbd348369f0e36abdfe218150cb3f263beef1
    end
  end
  end
