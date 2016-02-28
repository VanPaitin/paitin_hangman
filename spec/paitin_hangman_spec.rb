require 'spec_helper'

describe PaitinHangman do
  it 'has a version number' do
    expect(PaitinHangman::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end

describe Paitin do

  before :each do
    @instance = Paitin.new
  end

  describe '#new' do
    it 'returns a new game object' do
      expect(@instance).to be_a Paitin
    end

    it 'throws an error when instantiated with one or more parameters' do
      expect(Paitin.new "lala").to raise_error ArgumentError
    end
  end

  describe '#choice_integrity' do

    it 'returns an instance of Game' do
      allow(@instance).to receive(:gets.chomp).and_return('p')
      allow(@instance).to receive(:gets.chomp).and_return('i')
      allow(@instance).to receive(:gets.chomp).and_return('l')
      allow(@instance).to receive(:gets.chomp).and_return('q')
      expect(@instance.choice_integrity('p')).to respond_with Game.new
    end

    it 'gives an intruction and then calls the #process method' do
      allow(@instance).to receive(:process).and_return(nil)
      expect(@instance.choice_integrity('i')).to eq(nil)
    end

    it 'can quit the program' do
      expect(@instance.choice_integrity('q')).to exit
    end

    it 'can load a saved game' do
      expect(@instance.choice_integrity('l')).to respond_with GameResumption.new
    end

  end

  describe '#instruction' do

    it 'returns the process method' do
      expect(@instance.instruction).to respond_with process
    end

  end

end
