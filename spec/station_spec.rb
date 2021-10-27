require 'station'

describe Station do

  before(:each) do
    @name = double('name')
    @zone = double('zone')
    @station = Station.new(@name, @zone)
  end

  it 'has a name variable' do
    expect(@station.name).to eq @name
  end

  it 'has a zone variable' do
    expect(@station.zone).to eq @zone
  end

end
