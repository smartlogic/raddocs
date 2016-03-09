require 'spec_helper'

describe "Viewing Guides" do
  before do
    visit "/"
  end

  specify "guide links are included in the index listing" do
    expect(page).to have_selector(".guides")
    expect(page).to have_link("Authentication")
  end

  specify "loads the guide" do
    click_on "Authentication"

    expect(page).to have_content("Authentication")
  end
end
