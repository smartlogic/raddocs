require 'sinatra'
require 'json'
require 'raddocs/configuration'
require 'raddocs/app'

module Raddocs
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
  end
end
