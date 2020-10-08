require_relative '../lib/dark_trader'

describe "the method that retrieves the course of all cryptomonnages and saves them neatly in an array of hashes." do
  it "should match crypto symbols and crypto prices" do
    expect(get_crypto).to eq("{"BTC")
  end
end