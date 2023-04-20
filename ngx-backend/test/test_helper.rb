

ENV["RAILS_ENV"] ||= "test"
require 'simplecov'
class LineFilter < SimpleCov::Filter
  def matches?(source_file)
    source_file.lines.count < filter_argument
  end
end

SimpleCov.add_filter LineFilter.new(5)
SimpleCov.start do
  # filters.clear # This will remove the :root_filter and :bundler_filter that come via simplecov's defaults
  # add_filter do |src|
  #   !(src.filename =~ /^#{SimpleCov.root}/) unless src.filename =~ /my_engine/
  # end
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Long files" do |src_file|
    src_file.lines.count > 100
  end
  add_group "Multiple Files", ["app/models", "app/controllers"] # You can also pass in an array
  add_group "Short files", LineFilter.new(5) # Using the LineFilter class defined in Filters section above
end
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

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