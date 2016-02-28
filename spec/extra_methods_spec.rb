require 'spec_helper'

class DummyClass; end
describe PaitinHangman:SimpleMethods do

  before(:each) do
    @dummy = DummyClass.new
    @dummy.extend(Say)
  end

  describe '#play' do

    it 'can print to the console' do
      expect(@dummy.play('lala')).to output("1)\tPlay against a Human Player, press 1").to_stdout
      expect(@dummy.play('lala')).to output("2)\tPlay against Computer, press 2").to_stdout
    end

  end

  describe '#option_integrity' do

    it 'returns either 1 or 2' do
      expect(option_integrity).to == 1
    end
  end
end