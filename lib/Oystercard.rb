class Oystercard
  attr_reader :balance

  CREDIT_LIMIT = 91
  def initialize(balance = 0)
    @balance = balance # or (balance: 0) as argument
  end

  def top_up(amount)
    @balance += amount
    raise "Topup not possible, #{CREDIT_LIMIT} is the limit" if @balance >= CREDIT_LIMIT
    @balance
  end
end
