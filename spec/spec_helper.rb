require 'nutmeg'
# From rspec generator
ENV["RAILS_ENV"] ||= 'test'

RSpec.configure do |config|
  config.order = "random"
end