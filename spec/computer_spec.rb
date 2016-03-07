require 'spec_helper'

describe 'PaitinHangman::Computer' do
  let(:computer) { PaitinHangman::Computer.new }

  describe '#level_integrity' do
    it "should return either '1', '2', or '3'" do
      allow(computer).to receive(:gets).and_return("3")
      allow(computer).to receive(:level).and_return("started")
      expect(computer.level_integrity("henry")).to eql("started")
    end

    it "should ask for input again if wrong input is entered" do
      allow(computer).to receive(:gets).and_return("0")
      allow(STDIN).to receive(:gets).and_return("1")
      allow(computer).to receive(:level).and_return("started")
      expect(computer.level_integrity("henry")).to eql("started")
    end

  end

  describe '#level' do

    it "can start a new level one" do
      allow(PaitinHangman::Levels).to receive(:new).and_return("level 1")
      expect(computer.level("1", "henry")).to eql "level 1"
    end

    it "can start a new level two" do
      allow(PaitinHangman::Levels).to receive(:new).and_return("level 2")
      expect(computer.level("2", "henry")).to eql "level 2"
    end

    it "can start a new level one" do
      allow(PaitinHangman::Levels).to receive(:new).and_return("level 3")
      expect(computer.level("3", "henry")).to eql "level 3"
    end
  end

end