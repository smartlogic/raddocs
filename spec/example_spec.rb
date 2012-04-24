require 'spec_helper'

describe "Example" do
  before do
    visit "/orders/creating_an_order"
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
        [p.find(".name").text, p.find(".description").text]
      end

      parameters.should == [
        ["name", "Name of order"],
        ["paid", "If the order has been paid for"],
        ["email", "Email of user that placed the order"]
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
        page.should have_content(%{"order": \{})
      end
    end

    it "should have the curl output" do
      within("#request-0 .curl") do
        page.should have_content("curl http://localhost:3000/orders")
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
          page.should have_content(%{"email": "email@example.com",})
        end
      end
    end
  end
end
