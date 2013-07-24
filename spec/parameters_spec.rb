require 'spec_helper'

describe Raddocs::Parameters do
  let(:parameters_raw) { [
    {
      "name" => "name",
      "description" => "Name of order",
      "required" => true,
      "scope" => "order",
      "Extra Data" => "string"
    },
    {
      "name" => "paid",
      "description" => "If the order has been paid for",
      "required" => true,
      "scope" => "order",
      "more-data" => "true"
    }
  ] }

  it "should handle extra parameters" do
    parameters = Raddocs::Parameters.new(parameters_raw).parse
    parameters.should == {
      "extra_keys" => ["Extra Data", "more-data"],
      "data" => [
        {
          "name" => "name",
          "description" => "Name of order",
          "required" => true,
          "scope" => "order",
          "Extra Data" => "string"
        },
        {
          "name" => "paid",
          "description" => "If the order has been paid for",
          "required" => true,
          "scope" => "order",
          "more-data" => "true"
        }
      ]
    }
  end
end
