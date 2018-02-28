class Journey #every oystercard will initialize with a Journey class
  attr_reader :list_of_journeys, :starting_station
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @list_of_journeys = []
  end
  def add_starting_station(station)
    @list_of_journeys.push(starting_station: station)
  end
  def add_exit_station(station)
    if @list_of_journeys.last == nil
      @list_of_journeys.push(exit_station: station)
    else
      @list_of_journeys.last[:exit_station] = station
    end
  end

  def in_journey?
    @starting_station != nil
  end

  def fare
    if list_of_journeys[-1].key?(:starting_station) && list_of_journeys[-1].key?(:exit_station)
      MINIMUM_FARE
    else
      PENALTY_FARE
    end
  end
end
