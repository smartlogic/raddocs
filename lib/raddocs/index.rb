module Raddocs
  class Index < Model
    attr_reader :resources

    def resources
      @resources.map { |resource| Resource.new(resource) }
    end
  end
end
