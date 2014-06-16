require 'spec_helper'

describe Raddocs::ResponseFields do
  let(:parameters_raw) { [
    {
      "name" => "name",
      "description" => "Name of order",
      "scope" => "order",
      "Extra Data" => "string"
    },
    {
      "name" => "paid",
      "description" => "If the order has been paid for",
      "scope" => "order",
      "more-data" => "true"
    }
  ] }

  it "should handle extra keys" do
    parameters = Raddocs::ResponseFields.new(parameters_raw).parse
    expect(parameters).to eq({
      "extra_keys" => ["Extra Data", "more-data"],
      "data" => [
        {
          "name" => "name",
          "description" => "Name of order",
          "scope" => "order",
          "Extra Data" => "string"
        },
        {
          "name" => "paid",
          "description" => "If the order has been paid for",
          "scope" => "order",
          "more-data" => "true"
        }
      ]
    })
  end

  it "should handle no data" do
    parameters = Raddocs::ResponseFields.new(nil).parse
    expect(parameters).to be_nil
  end

  it "should handle empty array" do
    parameters = Raddocs::ResponseFields.new([]).parse
    expect(parameters).to eq({
      "extra_keys" => [],
      "data" => [],
    })
  end
end
