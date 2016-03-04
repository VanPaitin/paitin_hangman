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

describe 'PaitinHangman::Player' do

  let(:player) { PaitinHangman::Player.new }

  describe '#first_player_name' do

    it 'can receive a name' do
      allow(player).to receive(:get_friend_name).and_return("Simon")
      expect(player.first_player_name("Mayowa")).to eql "Simon"
    end

  end

  describe '#get_friend_name' do
    it "can collect a friend's name and return a level" do
      allow(player).to receive(:verify_name_integrity).and_return("Simon")
      allow(player).to receive(:game).and_return("select a level")
      expect(player.get_friend_name("Mayowa")).to eql "select a level"
    end
  end

  describe '#game' do
    it 'can start a game' do
      allow(player).to receive(:verify_name_integrity).and_return("Simon")
      allow(player).to receive(:game_player).and_return("Simon")
      allow(player).to receive(:level_integrity).and_return("level 2")
      expect(player.game("Mayowa", "Simon")).to eql ("level 2")
    end
  end

  describe '#level_integrity' do
    it 'selects a level' do
      allow(player).to receive(:gets).and_return("f")
      allow(STDIN).to receive(:gets).and_return("1")
      allow(player).to receive(:select_level).and_return("1")
      expect(player.level_integrity("Mayowa", "Simon")).to eql "1"
    end
  end

  describe '#select_level' do

    it 'can start a level one game' do
      allow(PaitinHangman::Levels).to receive(:new).and_return("level 1")
      expect(player.select_level("1", "Mayowa", "Simon")).to eql "level 1" 
    end

    it 'can start a level two game' do
      allow(PaitinHangman::Levels).to receive(:new).and_return("level 2")
      expect(player.select_level("2", "Mayowa", "Simon")).to eql "level 2" 
    end

    it 'can start a level three game' do
      allow(PaitinHangman::Levels).to receive(:new).and_return("level 3")
      expect(player.select_level("3", "Mayowa", "Simon")).to eql "level 3"
    end
  end
end
