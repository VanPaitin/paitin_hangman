require 'spec_helper'


describe 'PaitinHangman::SimpleMethods::@dummyClass' do

  before(:each) do
    class DummyClass
      include PaitinHangman::SimpleMethods
    end
    @dummy = DummyClass.new
  end

  describe '#verify_name_integrity' do
    it 'verifies the name integrity' do
      allow(@dummy).to receive(:gets).and_return('Paitin1')
      allow(STDIN).to receive(:gets).and_return("Paitin")
      expect(@dummy.verify_name_integrity).to eql 'PAITIN'
    end
  end
  

  describe '#option_integrity' do

    it 'returns either 1 or 2' do
      allow(@dummy).to receive(:gets).and_return('3')
      allow(STDIN).to receive(:gets).and_return('1')
      expect(@dummy.option_integrity).to eql '1'
    end

    it 'returns either 1 or 2' do
      allow(@dummy).to receive(:gets).and_return('3')
      allow(STDIN).to receive(:gets).and_return('2')
      expect(@dummy.option_integrity).to eql '2'
    end
  end

  describe '#length_one?' do
    context 'can return true or false' do
      it { expect(@dummy.length_one?("1")).to eql true }
      it { expect(@dummy.length_one?("ab")).to eql false }
      it { expect(@dummy.length_one?("20")).to eql false }
    end
  end

  describe '#unique?' do
    
    it 'it is included in an array' do
      @dummy.instance_variable_set('@misses', ['a', 'b', 'c'])
      @dummy.instance_variable_set('@right_guesses', ['d', 'e', 'f'])
      expect(@dummy.unique?('c')).to eql false
    end

    it "it is not included in an array" do
      @dummy.instance_variable_set('@misses', ['a', 'b', 'c'])
      @dummy.instance_variable_set('@right_guesses', ['d', 'e', 'f'])
      expect(@dummy.unique?("g")).to eql true
    end
  end

  describe '#number?' do
    it 'should return true if number absent' do
      expect(@dummy.number?('abc')).to eql true
    end

    it 'should return false if number present' do
      expect(@dummy.number? 'passw0rd').to eql false
    end
  end

  describe '#choice_integrity' do
    it "can only return a 'r'" do
      allow(@dummy).to receive(:gets).and_return('f')
      allow(STDIN).to receive(:gets).and_return('r')
      allow(@dummy).to receive(:decide).and_return(nil)
      expect(@dummy.choice_integrity).to eql nil
    end

    it "can only return a 'q'" do
      allow(@dummy).to receive(:gets).and_return('q')
      allow(@dummy).to receive(:decide).and_return(nil)
      expect(@dummy.choice_integrity).to eql nil
    end
  end

  describe '#decide' do
    before(:each) do
      @paitin = PaitinHangman::Paitin.new
      allow(PaitinHangman::Paitin).to receive(:new).and_return(@paitin)
    end
    it 'can exit the game' do
      allow(@dummy).to receive(:exit).and_return nil
      expect(@dummy.decide('q')).to eql nil
    end

    it 'can start another game' do
      allow(@paitin).to receive(:play).and_return("game")
      expect(@paitin.decide('r')).to eql "game"
    end
  end
end