# frozen_string_literal: true

class Oystercard
  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise 'maximum balance exceeded' if amount + balance > MAXIMUM_BALANCE

    @balance += amount
  end
end
