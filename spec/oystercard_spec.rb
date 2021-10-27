# frozen_string_literal: true

require 'oystercard'

describe Oystercard do

  let 'station' do
    station = double('station')
  end
 
  let(:station2) { double('station2') }
  
  
  it 'it had a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'it top up the card with an amount' do
    expect(subject).to respond_to(:top_up).with(1).argument
    # expect(subject.top_up(10)).to eq 10
    # expect { subject.top_up 10 }.to change { subject.balance }.by 10
  end

  it 'raises error if the maximum balance is exceeded' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    # oystercard = Oystercard.new
    subject.top_up(90)
    expect { subject.top_up(1) }.to raise_error "maximum balance of #{maximum_balance} exceeded"
  end

  #it 'deducts amount from the balance' do
    #subject.top_up(10)
    #expect(subject.deduct(5)).to eq 5
  #end

  #it { is_expected.to respond_to(:deduct).with(1).argument }
 
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }

  it 'Allows me to touch in' do
    subject.top_up(10)
    subject.touch_in(station)
    expect(subject.in_journey?).to eq true
  end

  it 'Allow me to touch out' do
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.in_journey?).to eq false
  end

  it 'Will deduct the minimum fare from my balance' do
  subject.top_up(50)
  expect{subject.touch_out(station)}.to change {subject.balance}.by (-Oystercard::MINIMUM_BALANCE)
end

  it 'when I get a new card it is not in journey' do
    expect(subject.entry_station).to eq nil
  end

  it 'Not touch in if below minimum balance' do
    minimum_balance = Oystercard::MINIMUM_BALANCE
    expect{ subject.touch_in(station) }.to raise_error "Insufficient balance, minimum balance is #{minimum_balance}"
  end

  it 'remembers entry station after touch in' do
    subject.top_up(50)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end
  
  it 'remembers exit station after touch out' do
    subject.top_up(50)
    subject.touch_out(station)
    expect(subject.journey_history[0][1]).to eq station
  end

  it 'It stores the information of a whole journey' do
    subject.top_up(50)
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject.journey_history[0]).to eq [station, station2]
  end

  it 'should start with an empty journey history' do
    expect(subject.journey_history).to eq []
  end
end
