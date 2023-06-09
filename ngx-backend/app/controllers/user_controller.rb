require 'logger'
require_relative './concerns/json_web_token'
class UserController < ApplicationController
  include Authenticatable
  def initialize
    super
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
  end


  

  # MANAGERS can create new users

  def index
    @users = User.all
    @logger.info("View all users")
    render json: { user: @users }, status: :ok
  end

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

      @logger.info("There was and error logging in")
      render json: user.errors, status: :unprocessable_entity
      # render json: { error: "You are not authorized to access this resource." }, status: :unauthorized

      render json: { error: "You are not authorized to access this resource." }, status: :unauthorized

    end
  end
  end
