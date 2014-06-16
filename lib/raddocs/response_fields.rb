module Raddocs
  class ResponseFields
    def initialize(response_fields)
      @response_fields = response_fields
    end

    def parse
      return if @response_fields.nil?

      extra_keys = @response_fields.flat_map(&:keys).uniq - ["name", "description", "scope"]

      {
        "extra_keys" => extra_keys,
        "data" => @response_fields
      }
    end
  end
end
