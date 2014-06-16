require "spec_helper"

describe Raddocs do
  describe ".configuration" do
    it "should be a configuration" do
      expect(Raddocs.configuration).to be_a(Raddocs::Configuration)
    end
  end

  describe ".configuration" do
    it "should yeild the configuration" do
      Raddocs.configure do |config|
        expect(config).to be_a(Raddocs::Configuration)
      end
    end
  end
end
