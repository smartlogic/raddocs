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

    expect(last_response.body).to eq("Not intercepted")
  end

  it "should intercept doc requests" do
    get "/orders", {}, "HTTP_ACCEPT" => "text/docs+plain"

    expect(last_response.body).to eq("Creating an Order\n")
  end

  it "should notify of no docs" do
    get "/accounts", {}, "HTTP_ACCEPT" => "text/docs+plain"

    expect(last_response.body).to eq("Docs are not available for this resource.\n")
    expect(last_response.status).to eq(404)
  end
end
