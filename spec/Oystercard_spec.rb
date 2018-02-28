require './lib/Oystercard.rb'

describe Oystercard do
  subject(:card) { Oystercard.new } #gives subject for all tests the name 'card'
  let(:starting_station){ double :starting_station }
  let(:exit_station){double :exit_station}

  describe 'initialize' do
    it 'carries a balance' do
      balance = 0
      expect(card.balance).to eq balance
    end
    it 'has a status' do
      expect(card.status).to eq nil
    end
    it 'has an empty list of journeys by default' do
      expect(card.journey.list_of_journeys).to eq []
    end
  end

  describe 'top_up' do
    it 'can be topped up' do
      #balance = double('balance', :amount => 100, :balance => 0)
      #oystercard = Oystercard.new
      expect(card.top_up(50)).to eq 50
    end

    it 'refuses topup when balance reaches limit' do
      expect{ card.top_up(91) }.to raise_error "Topup not possible, #{Oystercard::CREDIT_LIMIT} is the limit"
    end
  end


  describe 'deduct fare' do
    xit 'deducts amount paid for journey' do
      card.top_up(20)
      expect(card.deduct(4)).to eq 16
    end

     it 'charges penalty' do
       card.top_up(10)
       card.touch_out(:exit_station)
       expect(card.balance).to eq 4
     end
  end

  describe 'touch in' do
    xit 'changes status to in_use' do
      card.top_up(10)
      card.touch_in(:starting_station)
      expect(card.status).to eq :in_use
    end

    it 'prevents touch in if not enough balance' do # aren't we missing info here, a balance for example?
      expect { card.touch_in(:starting_station) }.to raise_error 'Not enough money'
    end

    it 'registers starting station' do
      expect(card).to respond_to(:touch_in).with(1).argument #  similar to this? it { is_expected.to respond_to(:touch_in(:starting_station)).with(1).argument }
    end

    it 'stores entry station' do
      card.top_up(10)
      card.touch_in(:starting_station)
      expect(card.starting_station).to eq(:starting_station)
    end
  end

  describe 'touch_out' do
    it 'changes status back to nil' do
      card.top_up(10)
      card.touch_in(:starting_station)
      card.touch_out(:exit_station)
      expect(card.status).to eq nil
    end

    it 'deducts fare from card' do
      card.top_up(10)
      card.touch_in(:starting_station)
      expect { card.touch_out(:exit_station) }.to change { card.balance }.by(-1) #expect(card.touch_out).to eq 9
    end
  end

  describe 'in_journey' do
    it 'shows whether card is in use' do
      card.top_up(10)
      card.touch_in(:starting_station)
      expect(card.journey.in_journey?).to eq true
    end
  end

  describe 'describe journey' do
    it 'creates one journey' do
      card.top_up(10)
      card.touch_in(:starting_station)
      card.touch_out(:exit_station)
      expect(card.journey.list_of_journeys).to eq [{starting_station: :starting_station, exit_station: :exit_station}]
    end
  end
end
