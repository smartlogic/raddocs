require 'spec_helper'

describe 'Index' do
  before do
    visit "/"
  end

  it "should have the api name" do
    find("h1").should have_content("Raddocs Test")
  end

  it "should have the resource title" do
    within(".resource") do
      page.should have_content("Orders")
    end
  end

  it "should have the examples" do
    within(".examples") do
      examples = all(".example").map { |e| e.text.strip }
      examples.should == ["Creating an order", "Deleting an order"]
    end
  end

  it "should link to the examples" do
    click_link "Creating an order"

    within("h1") do
      page.should have_content("Orders API")
    end
  end
end
