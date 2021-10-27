# frozen_string_literal: true

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :entry_station



  def initialize
    @balance = 0
    @entry_station = nil
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
    in_journey?
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
    in_journey?
  end

  def in_journey?
    !!@entry_station
  end

end
