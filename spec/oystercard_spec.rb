require_relative '../lib/oystercard'

describe Oystercard do 
 
  it "it had a balance of zero" do
    expect(subject.balance).to eq(0)
  end
 
  it "it top up the card with an amount" do
    # expect(subject).to respond_to(:top_up).with(1).argument
    # expect(subject.top_up(10)).to eq 10
    expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
  end

  it "To raise error if maximum balance is exceeded" do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1 }.to raise_error "maximum balance exceeded"
    end

end
