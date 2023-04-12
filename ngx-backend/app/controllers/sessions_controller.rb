require_relative './concerns/json_web_token'
class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::DEBUG
  end

  def create
    @logger.info("Creating")
    credentials = JSON.parse(request.body.read)
    user = User.find_by(email: credentials["email"])
    puts user.password
    if user&.authenticate(credentials["password"])
      render json: {token: JSONWebToken.encode(user_id: user.id), id: user.id, name: user.name, manager: user.manager}, status: :created
    else
      render json: { error: "Invalid email or password"}, status: :unauthorized
    end
  end
end
