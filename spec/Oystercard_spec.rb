require './lib/Oystercard.rb'

describe Oystercard do
  subject(:card) { Oystercard.new } #gives subject for all tests the name 'card'

  describe 'initialize' do
    it 'carries a balance' do
      balance = 0
      #oystercard = Oystercard.new
      expect(card.balance).to eq balance
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
    it 'deducts amount paid for journey' do
      card.top_up(20)
      expect(card.deduct(4)).to eq 16
    end
  end
end
