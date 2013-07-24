Encoding.default_external = Encoding::UTF_8

require 'sinatra/base'
require 'json'
require 'raddocs/configuration'
require 'raddocs/app'
require 'raddocs/middleware'
require 'raddocs/parameters'

module Raddocs
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
  end
end
