require 'spec_helper'

describe Raddocs::Configuration do
  let(:configuration) { Raddocs::Configuration.new }

  subject { configuration }

  describe ".add_setting" do
    before do
      Raddocs::Configuration.add_setting :new_setting, :default => "default"
    end

    it 'should allow creating a new setting' do
      expect(configuration).to respond_to(:new_setting)
      expect(configuration).to respond_to(:new_setting=)
    end

    it 'should allow setting a default' do
      expect(configuration.new_setting).to eq("default")
    end

    it "should allow the default setting to be a lambda" do
      Raddocs::Configuration.add_setting :another_setting, :default => lambda { |config| config.new_setting }
      expect(configuration.another_setting).to eq("default")
    end
  end

  describe "default settings" do
    specify "docs_dir" do
      expect(subject.docs_dir).to eq("doc/api")
    end
    specify "guides_dir" do
      expect(subject.guides_dir).to eq("doc/guides")
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
