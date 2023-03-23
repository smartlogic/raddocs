# Load the constant
module Raddocs
  class App < Sinatra::Base
    class << self
      attr_accessor :markdown
    end
  end
end

begin
  require 'kramdown'

  Raddocs::App.markdown = true
rescue LoadError
  # do nothing, we won't load markdown files
end

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

    if markdown
      get "/guides/*" do
        file = "#{guides_dir}/#{params[:splat][0]}.md"
        erb :guide, locals: { guide: File.read(file) }, layout: false
      end
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

      (haml :example, :locals => { index: index, example: example }).html_safe
    end

    # Page not found
    not_found do
      "Example does not exist"
    end

    helpers do
      def link_to(name, link)
        %{<a href="#{url_location}#{link}">#{name}</a>}
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

      def guides
        return [] unless File.exist?(guides_index)
        YAML.load(File.read(guides_index)).map do |guide_hash|
          Guide.new(guide_hash)
        end
      end

      def guides_index
        File.join guides_dir, "guides.yml"
      end

      def guides_dir
        Raddocs.configuration.guides_dir
      end
    end
  end
end
