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
    response_fields = Raddocs::ResponseFields.new(parameters_raw)
    expect(response_fields.extra_keys).to eq(["Extra Data", "more-data"])
  end

  it "should handle no data" do
    response_fields = Raddocs::ResponseFields.new(nil)
    expect(response_fields.extra_keys).to be_nil
    expect(response_fields.fields).to be_nil
  end

  it "should handle empty array" do
    response_fields = Raddocs::ResponseFields.new([])
    expect(response_fields.extra_keys).to eq([])
  end
end
