# frozen_string_literal: true

class JsonWebToken
  def self.encode(payload)
    exp = 1.hour.from_now.to_i
    JWT.encode(payload, "secret_key", 'HS256', exp: exp)
  end

  def self.decode(token)
    JWT.decode(token, "secret_key", true, algorithm: 'HS256')[0]
  rescue JWT::VerificationError, JWT::ExpiredSignature
    raise JWT::ExpiredSignature, "Invalid token"
  rescue JWT::DecodeError => e
    raise JWT::DecodeError, "Decode Error"
  end
end