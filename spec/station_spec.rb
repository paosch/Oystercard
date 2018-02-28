require 'station'

describe Station do
  station = Station.new("name", 3)
  it 'has name' do
    expect(station.name).to eq "name"
  end

  it 'has zone' do
    expect(station.zone).to eq 3
  end
end
