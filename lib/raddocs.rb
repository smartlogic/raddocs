require 'sinatra'
require 'json'

class Raddocs < Sinatra::Base
  set :haml, :format => :html5

  get "/" do
    index = JSON.parse(File.read("docs/index.json"))
    haml :index, :locals => { :index => index }
  end

  get "/:resource/:example" do
    example = JSON.parse(File.read("docs/#{params[:resource]}/#{params[:example]}.json"))
    haml :example, :locals => { :example => example }
  end
end
