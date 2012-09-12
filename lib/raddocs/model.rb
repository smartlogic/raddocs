module Raddocs
  class Model
    def self.load(json_string)
      content = JSON.parse(json_string)
      new(content)
    end

    def initialize(attrs)
      attrs.each do |key, value|
        instance_variable_set(:"@#{key}", value) if respond_to?(key)
      end
    end
  end
end
