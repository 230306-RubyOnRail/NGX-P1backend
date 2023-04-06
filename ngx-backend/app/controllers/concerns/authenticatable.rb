# frozen_string_literal: true
require_relative './json_web_token'

module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
    attr_reader :current_user
  end

  private

  def authenticate_request!
    puts "Authenticating request"
    @current_user = User.find(JSONWebToken.decode(token)['user_id'])
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    render json: { error: 'You are not allowed to perform this action' }, status: 403 unless params[:user_id].to_i == @current_user.id
  end

  def token
    request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
  end
end