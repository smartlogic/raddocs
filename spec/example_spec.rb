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
        find("textarea").text.should =~ /"order":\{/
      end
    end

    it "should not show empty bodies" do
      page.should have_css("#request-1")
      page.should_not have_css("#request-1 > .body")
    end

    it "should pass along content type information to code mirror" do
      content = find("#request-0 .body .content")
      content["data-content-type"].should == "application/json"
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

      it "should pass along content type information to code mirror" do
        content = find("#request-0 .response .body .content")
        content["data-content-type"].should == "application/json; charset=utf-8"
      end
    end
  end

  it "should handle visiting a file that does not exist" do
    visit "/orders/creating_an_orders"

    page.should have_content("Example does not exist")
  end
end
