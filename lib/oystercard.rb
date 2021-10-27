# frozen_string_literal: true

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance
  attr_reader :in_journey


  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end


  def deduct(amount)
    @balance -= amount
  end

  private :deduct

  def touch_in
  fail "Insufficient balance, minimum balance is #{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
  @in_journey = true
  
  end

  def touch_out
  deduct(MINIMUM_BALANCE)
  @in_journey = false
  end
end
