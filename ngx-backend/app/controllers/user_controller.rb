require 'logger'
class UserController < ApplicationController

  def initialize
    super
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
  end

  skip_before_action :verify_authenticity_token
  def create
    user = User.new(JSON.parse(request.body.read))
    if user.save
      @logger.info("User successfully logged in")
      render json: user, status: :created
    else
      @logger.info("User successfully logged in")
      render json: user.errors, status: :unprocessable_entity
    end
  end

  end
