require 'raddocs'
require 'rack/test'
require 'capybara/rspec'

module Raddocs
  class App
    set :environment, :test
  end
end

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before do
    Capybara.app = Raddocs::App
  end
end

Raddocs.configure do |config|
  config.api_name = "Raddocs Test"
  config.docs_dir = "spec/fixtures"
end
