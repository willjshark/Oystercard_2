# frozen_string_literal: true

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :entry_station, :journey_history



  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def top_up(amount)
    raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end


  def deduct(amount)
    @balance -= amount
  end

  private :deduct

  def touch_in(station)
    fail "Insufficient balance, minimum balance is #{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_BALANCE)
    journey = [@entry_station, station]
    @journey_history << journey
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

end
