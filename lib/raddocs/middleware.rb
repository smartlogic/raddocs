module Raddocs
  # Rack middleware
  #
  # This lets you cURL for documentation.
  #
  #   curl -H "Accept: text/docs+plain" http://localhost/orders
  #
  # This will return all of the docs for a given resource, "orders." It is returned
  # as a giant flat file containing all of the documentation. "combined_text" output
  # must be selected in `rspec_api_documentation`.
  #
  # The route matches the folder structure of the docs.
  class Middleware
    def initialize(app)
      @app = app
      @file_server = Rack::File.new(Raddocs.configuration.docs_dir)
    end

    def call(env)
      if env["HTTP_ACCEPT"] =~ Raddocs.configuration.docs_mime_type
        env = env.merge({ "PATH_INFO" => File.join(env["PATH_INFO"], "index.txt") })
        response = @file_server.call(env)

        if response[0] == 404
          body = "Docs are not available for this resource.\n"
          response = [404, {"Content-Type" => "type/plain", "Content-Length" => body.size.to_s}, [body]]
        end

        response
      else
        @app.call(env)
      end
    end
  end
end
