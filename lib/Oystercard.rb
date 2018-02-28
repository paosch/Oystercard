require 'journey'


class Oystercard
  attr_accessor :balance, :status, :starting_station, :exit_station, :list_of_journeys, :journey

  CREDIT_LIMIT = 91
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  def initialize(balance = 0, journey = Journey.new) #a new oyster begins with zero balance
    @balance = balance # or (balance: 0) as argument?
    #@status = nil
    @starting_station = nil
    @exit_station = nil
    #list_of_journeys moved to Journey class
    @journey = journey
  end

  def top_up(amount)
    @balance += amount
    raise "Topup not possible, #{CREDIT_LIMIT} is the limit" if @balance >= CREDIT_LIMIT
    @balance # needs to return the changed balance, not nil from previous expression
  end

  def touch_in(station)
    @starting_station = station
    raise 'Not enough money' if @balance < MINIMUM_FARE # if we put this at the end it returns nil
    #@status = :in_use
    #list_of_journeys moved to Journey class
    @journey.add_starting_station(station)
  end

  def touch_out(station)
    @starting_station = nil
    @exit_station = station
    # list_of_journeys moved to Journey class
    @journey.add_exit_station(station)
    deduct
  end

  #def in_journey?
    #@starting_station != nil
  #end

  private

  def deduct
    # if @journey.list_of_journeys[-1].key?(:starting_station) && @journey.list_of_journeys[-1].key?(exit_station)
    #   @balance -= amount
    # else
    #   @balance -= 6
    # end
    @balance -= @journey.fare
  end
end
