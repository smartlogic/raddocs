require 'sinatra'
require 'json'

class Raddocs < Sinatra::Base
  set :haml, :format => :html5

  get "/" do
    index = JSON.parse(File.read("#{docs_dir}/index.json"))
    haml :index, :locals => { :index => index }
  end

  get "/:resource/:example" do
    example = JSON.parse(File.read("#{docs_dir}/#{params[:resource]}/#{params[:example]}.json"))
    haml :example, :locals => { :example => example }
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
