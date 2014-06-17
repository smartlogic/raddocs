require 'spec_helper'

describe Raddocs::Parameters do
  let(:parameters_hash) { [
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
    parameters = Raddocs::Parameters.new(parameters_hash)
    expect(parameters.extra_keys).to eq(["Extra Data", "more-data"])
  end

  specify "loads params" do
    parameters = Raddocs::Parameters.new(parameters_hash)
    expect(parameters.params.count).to eq(2)
  end
end
