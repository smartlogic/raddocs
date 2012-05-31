require 'spec_helper'

describe "Mountable" do
  before do
    Capybara.app = Rack::Builder.new do
      map "/docs" do
        run Raddocs::App
      end
    end

    visit "/docs"
  end

  it "should show the index page" do
    page.should have_content("Api Documentation")
  end

  it "should update the links" do
    click_link "Creating an order"

    current_path.should == "/docs/orders/creating_an_order"
    page.should have_content("Orders API")
  end
end
