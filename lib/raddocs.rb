Encoding.default_external = Encoding::UTF_8

require 'sinatra/base'
require 'json'

require 'raddocs/configuration'
require 'raddocs/app'
require 'raddocs/middleware'

require 'raddocs/models'

module Raddocs
  # @return [Raddocs::Configuration] the current configuration
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Configure Raddocs
  #
  # @example
  #   Raddocs.configure do |config|
  #     config.url_prefix = "/documentation"
  #   end
  #
  # @yieldparam configuration [Raddocs::Configuration]
  def self.configure
    yield configuration if block_given?
  end
end
