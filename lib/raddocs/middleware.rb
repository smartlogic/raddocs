module Raddocs
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
