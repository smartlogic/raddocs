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
    expect(page).to have_content("Raddocs Test")
  end

  it "should update the links" do
    click_link "Creating an order"

    expect(current_path).to eq("/docs/orders/creating_an_order")
    expect(page).to have_content("Orders API")
  end
end
