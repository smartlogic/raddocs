module Raddocs
  class Interaction < Model
    attr_reader :request_headers, :request_method, :request_path, :request_query_parameters,
      :request_body, :request_content_type, :curl, :response_status, :response_headers, 
      :response_body, :response_content_type
  end
end
