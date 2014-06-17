module Raddocs
  class Index
    def initialize(file)
      @attrs = JSON.parse(File.read(file))
    end

    def resources
      @attrs.fetch("resources", {}).map do |resource|
        Resource.new(resource["name"], resource["examples"])
      end
    end
  end

  class Resource < Struct.new(:name, :examples)
    def examples
      @examples ||= super.map do |example|
        IndexExample.new(example)
      end
    end
  end

  class IndexExample
    attr_reader :description, :link

    def initialize(attributes)
      @description = attributes.fetch("description")
      @link = attributes.fetch("link")
    end

    def href
      link.gsub(".json", "")
    end
  end

  class Example
    attr_reader :resource, :description, :explanation, :parameters, :response_fields,
      :requests

    def initialize(file)
      @attrs = JSON.parse(File.read(file))

      @resource = @attrs.fetch("resource")
      @description = @attrs.fetch("description")
      @explanation = @attrs.fetch("explanation", nil)
      @parameters = Parameters.new(@attrs.fetch("parameters"))
      @response_fields = ResponseFields.new(@attrs.fetch("response_fields"))
      @requests = @attrs.fetch("requests").map { |request| Request.new(request) }
    end

    def [](key)
      @attrs[key]
    end

    def explanation?
      !explanation.nil?
    end
  end

  class Parameters
    attr_reader :extra_keys, :params

    SPECIAL_KEYS = ["name", "description", "required", "scope"]

    def initialize(params)
      @params = params.map { |param| Parameter.new(param) }
      @extra_keys = params.flat_map(&:keys).uniq - SPECIAL_KEYS
    end

    def present?
      @params.count > 0
    end
  end

  class Parameter
    attr_reader :name, :description, :required, :scope

    def initialize(attributes)
      @attrs = attributes

      @name = attributes.fetch("name")
      @description = attributes.fetch("description")
      @required = attributes.fetch("required", false)
      @scope = attributes.fetch("scope", nil)
    end

    def required?
      !!@required
    end

    def scope?
      !!@scope
    end

    def [](key)
      @attrs[key]
    end
  end

  class ResponseFields
    attr_reader :extra_keys, :fields

    SPECIAL_KEYS = ["name", "description", "scope"]

    def initialize(response_fields)
      return unless response_fields # Might not be present
      @fields = response_fields.map { |field| ResponseField.new(field) }
      @extra_keys = response_fields.flat_map(&:keys).uniq - SPECIAL_KEYS
    end

    def present?
      @fields.count > 0
    end
  end

  class ResponseField
    attr_reader :name, :description, :scope

    def initialize(attributes)
      @attrs = attributes

      @name = attributes.fetch("name")
      @description = attributes.fetch("description")
      @scope = attributes.fetch("scope", nil)
    end

    def scope?
      !!@scope
    end

    def [](key)
      @attrs[key]
    end
  end

  class Request
    attr_reader :request_method, :request_path, :request_query_parameters, :request_body,
      :curl, :response_status, :response_body

    def initialize(attributes)
      @attrs = attributes

      @request_headers = attributes.fetch("request_headers")
      @request_method = attributes.fetch("request_method")
      @request_path = attributes.fetch("request_path")
      @request_query_parameters = attributes.fetch("request_query_parameters", nil)
      @request_body = attributes.fetch("request_body", nil)
      @curl = attributes.fetch("curl", nil)
      @response_status = attributes.fetch("response_status")
      @response_headers = attributes.fetch("response_headers", {})
      @response_body = attributes.fetch("response_body", nil)
    end

    # There are unwanted indents if this was a simple each and output in haml
    def request_headers
      @request_headers.map do |header, value|
        "#{header}: #{value}"
      end.join("\n")
    end

    def request_query_parameters
      @request_query_parameters.map { |k,v| "#{k}=#{v}" }.join("\n")
    end

    def request_query_parameters?
      !@request_query_parameters.empty?
    end

    def request_body?
      !@request_body.nil?
    end

    def request_content_type
      @request_headers["Content-Type"]
    end

    def curl?
      !@curl.nil?
    end

    def response?
      !@response_status.nil?
    end

    # There are unwanted indents if this was a simple each and output in haml
    def response_headers
      @response_headers.map do |header, value|
        "#{header}: #{value}"
      end.join("\n")
    end

    def response_body?
      !@response_body.nil?
    end

    def response_content_type
      @response_headers["Content-Type"]
    end
  end
end
