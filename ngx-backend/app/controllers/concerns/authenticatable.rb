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
    puts token
    token_data = JSONWebToken.decode(token)
    @current_user = User.find(JSONWebToken.decode(token)['user_id'])
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    render json: { error: 'You are not allowed to perform this action' }, status: 403 unless @current_user.id == token_data['user_id'].to_i
  end

  def token
    request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
  end

end