require "spec_helper"

describe Raddocs do
  describe ".configuration" do
    it "should be a configuration" do
      Raddocs.configuration.should be_a(Raddocs::Configuration)
    end
  end

  describe ".configuration" do
    it "should yeild the configuration" do
      Raddocs.configure do |config|
        config.should be_a(Raddocs::Configuration)
      end
    end
  end
end
