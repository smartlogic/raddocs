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
      @requests = @attrs.fetch("requests")
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
      @params = params
      @extra_keys = @params.flat_map(&:keys).uniq - SPECIAL_KEYS
    end

    def present?
      @params.count > 0
    end
  end

  class ResponseFields
    attr_reader :extra_keys, :fields

    SPECIAL_KEYS = ["name", "description", "scope"]

    def initialize(response_fields)
      @fields = response_fields
      @extra_keys = @fields.flat_map(&:keys).uniq - SPECIAL_KEYS if @fields
    end

    def present?
      @fields.count > 0
    end
  end
end
