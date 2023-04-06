require_relative './concerns/json_web_token'
class SessionsController < ApplicationController
  def create
    credentials = JSON.parse(request.body.read)
    user = User.find_by(email: credentials["email"])
    if user&.authenticate(credentials["password"])
      render json: {token: JSONWebToken.encode(user_id: user.id), user_id: user.id, name: user.name}, status: :ok
    else
      render json: { error: "Invalid email or password"}, status: :unauthorized
    end
  end
end
