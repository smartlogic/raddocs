require 'spec_helper'

describe Raddocs::Parameter do
  specify "scope is a single level" do
    parameter = Raddocs::Parameter.new({
      "name" => "name",
      "description" => "Name of order",
      "scope" => "order",
    })

    expect(parameter.scope).to eq("order")
  end

  specify "scope is a multi-level" do
    parameter = Raddocs::Parameter.new({
      "name" => "name",
      "description" => "Name of order",
      "scope" => ["order", "attributes"],
    })

    expect(parameter.scope).to eq("order[attributes]")
  end
end
