ENV["RAILS_ENV"] ||= "test"
require "garage"

require File.expand_path("../dummy/config/environment", __FILE__)
require "rspec/rails"
require "rspec/autorun"
require "webmock/rspec"
require "garage/test/authentication_helper"

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.include FactoryGirl::Syntax::Methods
  config.include RSpec::JsonMatcher, type: :request
  config.include Garage::Test::AuthenticationHelper, type: :request
  config.infer_spec_type_from_file_location!

  config.before(:each) do
    Rails.cache.clear
  end
end

Garage.configuration.auth_center_url = "http://auth.example.com/oauth/token"
