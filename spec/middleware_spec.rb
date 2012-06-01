require 'spec_helper'

describe Raddocs::Middleware do
  include Rack::Test::Methods

  before do
    Raddocs.configure do |config|
      config.docs_mime_type = /text\/docs\+plain/
    end
  end

  let(:app) {
    Rack::Builder.new do
      use Raddocs::Middleware
      run lambda { |env|
        [200, {}, ["Not intercepted"]]
      }
    end
  }

  it "should only respond when accept is correct" do
    get "/orders", {}, "HTTP_ACCEPT" => "application/json"

    last_response.body.should == "Not intercepted"
  end

  it "should intercept doc requests" do
    get "/orders", {}, "HTTP_ACCEPT" => "text/docs+plain"

    last_response.body.should == "Creating an Order\n"
  end

  it "should notify of no docs" do
    get "/accounts", {}, "HTTP_ACCEPT" => "text/docs+plain"

    last_response.body.should == "Docs are not available for this resource.\n"
    last_response.status.should == 404
  end
end
