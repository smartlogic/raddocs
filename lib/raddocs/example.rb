module Raddocs
  class Example < Model
    attr_reader :resource, :description, :explanation

    def initialize(attrs)
      @resource = attrs.fetch("resource")
      @description = attrs.fetch("description")
      @explanation = attrs.fetch("explanation", "")
      @parameters = attrs.fetch("parameters", [])
      @requests = attrs.fetch("requests", [])
    end

    def parameters
      @params ||= @parameters.map { |param| Parameter.new(param) }
    end

    def interactions
      @interactions ||= @requests.map { |interaction| Interaction.new(interaction) }
    end
  end
end
