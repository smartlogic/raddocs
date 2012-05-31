require 'sinatra'
require 'json'

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

    class << self
      attr_accessor :docs_dir

      def docs_dir
        @docs_dir ||= "docs"
      end
    end

    def docs_dir
      self.class.docs_dir
    end
  end
end
