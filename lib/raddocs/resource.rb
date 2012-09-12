module Raddocs
  class Resource < Model
    attr_reader :name, :examples

    def examples
      @examples.map { |example| Example.new(example) }
    end
  end
end
