require 'spec_helper'

describe Raddocs::Configuration do
  let(:configuration) { Raddocs::Configuration.new }

  subject { configuration }

  its(:settings) { should == {} }

  describe ".add_setting" do
    before do
      Raddocs::Configuration.add_setting :new_setting, :default => "default"
    end

    it 'should allow creating a new setting' do
      configuration.should respond_to(:new_setting)
      configuration.should respond_to(:new_setting=)
    end

    it 'should allow setting a default' do
      configuration.new_setting.should == "default"
    end

    it "should allow the default setting to be a lambda" do
      Raddocs::Configuration.add_setting :another_setting, :default => lambda { |config| config.new_setting }
      configuration.another_setting.should == "default"
    end
  end

  describe "default settings" do
    its(:docs_dir) { should == "docs" }
    its(:docs_mime_type) { should == /text\/docs\+plain/ }
  end
end
