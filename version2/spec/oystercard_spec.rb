require 'oystercard'
describe Oystercard do
  it 'starts with a balance of zero' do
    expect(subject.balance).to eq 0
  end
  describe '#top_up' do
    it 'the user can add money to the card' do
      expect { subject.top_up(50) }.to change { subject.balance }.by 50
    end
  end
end
