module Raddocs
  class Example < Model
    attr_reader :resource, :description, :explanation, :parameters, :requests, :link

    def parameters
      @parameters.map { |param| Parameter.new(param) }
    end

    def interactions
      @requests.map { |interaction| Interaction.new(interaction) }
    end
  end
end
