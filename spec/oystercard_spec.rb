require_relative '../lib/oystercard'

describe Oystercard do 
it "It had a balance of zero" do
  expect(subject.balance).to eq(0)
  end
end
