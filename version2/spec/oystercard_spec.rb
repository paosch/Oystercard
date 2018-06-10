require 'oystercard'
describe Oystercard do
  it 'starts with a balance at zero' do
    expect(subject.balance).to eq 0
  end
end
