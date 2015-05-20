module Raddocs
  # Sinatra app that serves all documentation
  class App < Sinatra::Base
    set :haml, :format => :html5
    set :root, File.join(File.dirname(__FILE__), "..")

    # Main index, displays all examples grouped by resource
    get "/" do
      index = Index.new(File.join(docs_dir, "index.json"))
      haml :index, :locals => { :index => index }
    end

    # Allows for overriding styles
    get "/custom-css/*" do
      file = "#{docs_dir}/styles/#{params[:splat][0]}"

      if !File.exists?(file)
        raise Sinatra::NotFound
      end

      content_type :css
      File.read(file)
    end

    # Catch all for example pages.
    # Loads files from the docs dir and appends '.json'.
    #
    # @example
    #   "/orders/create_an_order" => "docs/api/orders/create_an_order.json"
    get "/*" do
      file = "#{docs_dir}/#{params[:splat][0]}.json"

      if !File.exists?(file)
        raise Sinatra::NotFound
      end

      index = Index.new(File.join(docs_dir, "index.json"))
      example = Example.new(file)

      haml :example, :locals => { index: index, example: example }
    end

    # Page not found
    not_found do
      "Example does not exist"
    end

    helpers do
      def link_to(name, link, options={})
        %{<a href="#{url_location}#{link}" class="#{options['class']}">#{name}</a>}
      end

      def url_location
        "#{url_prefix}#{request.env["SCRIPT_NAME"]}"
      end

      def url_prefix
        url = Raddocs.configuration.url_prefix
        return '' if url.to_s.empty?
        url.start_with?('/') ? url : "/#{url}"
      end

      def api_name
        Raddocs.configuration.api_name
      end

      # Loads all necessary css files
      #
      # @see Raddocs::Configuration for loading external files
      def css_files
        files = ["#{url_location}/codemirror.css", "#{url_location}/application.css"]

        if Raddocs.configuration.include_bootstrap
          files << "#{url_location}/bootstrap.min.css"
        end

        Dir.glob(File.join(docs_dir, "styles", "*.css")).each do |css_file|
          basename = Pathname.new(css_file).basename
          files << "#{url_location}/custom-css/#{basename}"
        end

        files.concat Array(Raddocs.configuration.external_css)

        files
      end

      def docs_dir
        Raddocs.configuration.docs_dir
      end

      def index_view
        Raddocs.configuration.index_view
      end
    end
  end
end
