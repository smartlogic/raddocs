require 'sinatra'
require 'json'
require 'raddocs/configuration'

module Raddocs
  class App < Sinatra::Base
    set :haml, :format => :html5

    get "/" do
      index = JSON.parse(File.read("#{docs_dir}/index.json"))
      haml :index, :locals => { :index => index }
    end

    get "/*" do
      file = "#{docs_dir}/#{params[:splat][0]}.json"

      if !File.exists?(file)
        raise Sinatra::NotFound
      end

      file_content = File.read(file)

      example = JSON.parse(file_content)
      haml :example, :locals => { :example => example }
    end

    not_found do
      "Example does not exist"
    end

    helpers do
      def link_to(name, link)
        %{<a href="#{request.env["SCRIPT_NAME"]}#{link}">#{name}</a>}
      end

      def url_location
        request.env["SCRIPT_NAME"]
      end
    end

    def docs_dir
      Raddocs.configuration.docs_dir
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
  end
end
