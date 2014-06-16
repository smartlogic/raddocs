require 'spec_helper'

describe 'Index' do
  before do
    visit "/"
  end

  it "should have the api name as the title" do
    expect(find("head title")).to have_content("Raddocs Test")
  end

  it "should have the api name" do
    expect(find("h1")).to have_content("Raddocs Test")
  end

  it "should have the resource title" do
    within(".resource") do
      expect(page).to have_content("Orders")
    end
  end

  it "should have the examples" do
    within(".examples") do
      examples = all(".example").map { |e| e.text.strip }
      expect(examples).to eq(["Creating an order", "Deleting an order"])
    end
  end

  it "should link to the examples" do
    click_link "Creating an order"

    within("h1") do
      expect(page).to have_content("Orders API")
    end
  end
end
