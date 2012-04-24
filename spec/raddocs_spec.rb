require 'spec_helper'

describe Raddocs do
  it "should provide a setting for docs dir" do
    Raddocs.docs_dir.should == "spec/fixtures"
  end
end
