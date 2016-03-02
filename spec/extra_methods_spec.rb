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
  describe '#play' do
    before(:each) do
      
      allow(PaitinHangman::Computer).to receive(:new).and_return(nil)
      allow(PaitinHangman::Player).to receive(:new).and_return(nil)
    end

    context "if it is '2'" do
      before(:each) do
        allow(@dummy).to receive(:option_integrity).and_return('2')
        @dummy.instance_variable_set("@option", @dummy.option_integrity)
      end
      specify {expect{@dummy.play('lala')}.to output("1)\tPlay against a Human Player, press 1\n2)\tPlay against Computer, press 2\n").to_stdout}
    end

    context "if it is '1'" do
      before(:each) do
        allow(@dummy).to receive(:option_integrity).and_return('1')
      end
      specify {expect{@dummy.play('lala')}.to output("1)\tPlay against a Human Player, press 1\n2)\tPlay against Computer, press 2\n").to_stdout}
    end
  

    it 'can create an instance of Computer' do
      allow(@dummy).to receive(:option_integrity).and_return(nil)
      allow(PaitinHangman::Computer).to receive(:new).and_return(nil)
      allow(PaitinHangman::Player).to receive(:new).and_return(nil)
      expect(@dummy.play('lala')).to eql nil
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
    it 'can return true or false' do
      expect(@dummy.length_one?("1")).to eql true
      expect(@dummy.length_one?("ab")).to eql false
      expect(@dummy.length_one?("20")).to eql false
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
    it 'can exit the game' do
      allow(@dummy).to receive(:exit).and_return nil
      expect(@dummy.decide('q')).to eql nil
    end

    it 'can start another game' do
      allow(@dummy).to receive(:play).and_return(nil)
      expect(@dummy.decide('r')).to eql nil
    end
  end
end