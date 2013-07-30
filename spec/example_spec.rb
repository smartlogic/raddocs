require 'spec_helper'

describe "Example" do
  before do
    visit "/orders/creating_an_order"
  end

  it "should include custom css and not bootstrap" do
    links = page.all("link").map do |link|
      link[:href]
    end.sort

    links.should == ["/application.css", "/codemirror.css", "http://example.com/my-external.css"]
  end

  it "should have a link back to index" do
    click_link "Back to Index"

    current_path.should == "/"
  end

  it "should have the resource title" do
    within("h1") do
      page.should have_content("Orders API")
    end
  end

  it "should have the example description" do
    within("h2") do
      page.should have_content("Creating an order")
    end
  end

  it "should have the parameters table" do
    within(".parameters") do
      parameters = all(".parameter").map do |p|
        [p.find(".name").text, p.find(".description").text, p.find(".extras").text]
      end

      parameters.should == [
        ["order[name]", "Name of order", "string"],
        ["order[paid]", "If the order has been paid for", "integer"],
        ["order[email]", "Email of user that placed the order", "string"]
      ]
    end
  end

  it "should have the requests" do
    all(".request").count.should == 2
  end

  context "requests" do
    it "should have the headers" do
      within("#request-0 .headers") do
        page.should have_content("Accept: application/json")
      end
    end

    it "should have the route" do
      within("#request-0 .route") do
        page.should have_content("POST /orders")
      end
    end

    it "should have the body" do
      within("#request-0 .body") do
        find("textarea").text.should =~ /"order":\{/
      end
    end

    it "should have the curl output" do
      within("#request-0 .curl") do
        page.should have_content("curl \"http://localhost:3000/orders\"")
      end
    end

    context "response" do
      it "should have the headers" do
        within("#request-0 .response .headers")  do
          page.should have_content("Content-Type: application/json")
        end
      end

      it "should have the status" do
        within("#request-0 .response .status") do
          page.should have_content("201")
        end
      end

      it "should have the body" do
        within("#request-0 .response .body") do
          find("textarea").text.should =~ /"email":"email@example\.com"/
        end
      end
    end
  end

  it "should handle visiting a file that does not exist" do
    visit "/orders/creating_an_orders"

    page.should have_content("Example does not exist")
  end
end
