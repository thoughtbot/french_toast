ENV["RACK_ENV"] = "test"

require "bundler/setup"
require "capybara-webkit"
require "database_cleaner"
require "delayed_job_active_record"

require File.expand_path("../../spec/dummy/config/environment", __FILE__)

require "french_toast"

abort("DATABASE_URL environment variable is set") if ENV["DATABASE_URL"]

require "rspec/rails"

Dir[File.join("./spec/support/**/*.rb")].sort.each { |file| require file }

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
end

ActiveRecord::Migration.maintain_test_schema!
