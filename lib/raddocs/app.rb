module Raddocs
  class App < Sinatra::Base
    set :haml, :format => :html5
    set :root, File.join(File.dirname(__FILE__), "..")

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
      example["requests"].each do |request|
        request["request_content_type"] = request["request_headers"]["Content-Type"]
        request["response_content_type"] = request["response_headers"]["Content-Type"]
      end

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

      def api_name
        Raddocs.configuration.api_name
      end
    end

    def docs_dir
      Raddocs.configuration.docs_dir
    end
  end
end
