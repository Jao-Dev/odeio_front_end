require_relative "dummy/config/environment"
require "rspec/rails"
require "capybara/rspec"
require "view_component/test_helpers"

RSpec.configure do |config|
  config.include ViewComponent::TestHelpers, type: :component
  config.infer_spec_type_from_file_location!
end
