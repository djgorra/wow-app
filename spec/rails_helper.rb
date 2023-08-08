# This file is copied to spec/ when you run 'rails generate rspec:install'

#Note: undefined method `filter_backtrace' means you are using "assert" in place of "assert_equal"
#Note: "cannot modify frozen array" means there is a load error further up

# require 'simplecov'
# require 'simplecov-rcov'
# SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
# SimpleCov.start 'rails'
# SimpleCov.start do
#   #add_filter '/lib/'
#   add_filter '/vendor/'
#   add_filter "app/middleware"
#   add_filter 'app/admin'
#   add_filter 'app/models/ftp'
#   add_filter 'app/models/data_sources/inactive'
#   add_group 'Controllers', 'app/controllers'
#   add_group 'Models', 'app/models'
#   add_group 'Helpers', 'app/helpers'
#   add_group 'Mailers', 'app/mailers'
#   add_group 'Views', 'app/views'
# end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_bot'
#require 'stripe_mock'
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|


end
