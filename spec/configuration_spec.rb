require 'spec_helper'

describe Raddocs::Configuration do
  let(:configuration) { Raddocs::Configuration.new }

  subject { configuration }

  specify "settings are empty" do
    expect(subject.settings).to eq({})
  end

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
    specify "docs_dir" do
      expect(subject.docs_dir).to eq("doc/api")
    end
    specify "docs_mime_type" do
      expect(subject.docs_mime_type).to eq(/text\/docs\+plain/)
    end
    specify("api_name") do
      expect(subject.api_name).to eq("Api Documentation")
    end
    specify("include_bootstrap") do
      expect(subject.include_bootstrap).to be_truthy
    end
    specify("external_css") do
      expect(subject.external_css).to be_empty
    end
    specify("url_prefix") do
      expect(subject.url_prefix).to be_nil
    end
  end
end
