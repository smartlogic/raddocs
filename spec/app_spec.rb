require 'spec_helper'

describe Raddocs::App do
  it "should provide a setting for docs dir" do
    Raddocs::App.docs_dir.should == "spec/fixtures"
  end
end
