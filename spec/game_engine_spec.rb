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
# end

  describe '#level' do
    it "can start a new level" do
      allow(PaitinHangman::Levels).to receive(:new).and_return("level 1")
      expect(computer.level("1", "henry")).to eql "level 1"
    end
  end
end

# describe 'PaitinHangman::Player' do
#   @player = PaitinHangman::Player.new


#   describe '#get_friend_name' do
#     context 'it receives player name' do
#       @player.instance_variable_set("player1", "Mayowa")
#       specify { expect { @player }.to output("Hi #{player1}, what is the name of your friend").to_stdout }
#       allow(@player).to receive(:verify_name_integrity).and_return("Simon Peter")
#       expect(@player.get_friend_name).to eql ("Simon Peter")
#     end

#   end

#   describe '#game' do
#     @player.instance_variable_set("@player1", "Mayowa")
#     @player.instance_variable_set("@player2", "Simon Peter")
#     allow(@player).to receive(:verify_name_integrity).and_return("Simon")
#     allow(@player).to receive(:game_player).and_return("Simon Peter")
#     # specify { expect { @player.game }.to output("Enter the Level you would like to play. You may press...
#     # 1 for Beginner (4 - 8 character word)
#     # 2 for Intermediate (9 - 12 character word)
#     # 3 for Advanced (word has above 12 characters)".yellow)to_stdout }
#     allow(@player).to receive(:select_level).and_return(nil)
#     expect(@player.game).to eql (nil)
#   end

#   describe '#game_player' do
#     @player.instance_variable_set("@player1", "Mayowa")
#     @player.instance_variable_set("@player2", "Simon Peter")
#     specify { expect {@player.game_player}.to output("Please enter one of your names: #{@player1} or #{@player2}").to_stdout}
#     allow(@player).to receive(:verify_name_integrity).and_return("Mayowa")
#     expect(@player.game_player).to eql ("Mayowa")
#   end

#   describe '#select_level' do

#     it 'can start a level one game' do
#       allow(@player).to receive(:level_integrity).and_return('1')
#       allow(PaitinHangman::Levels).to receive(:new).and_return(nil)
#       expect(@player.select_level).to eql nil
#     end

#     it 'can start a level two game' do
#       allow(@player).to receive(:level_integrity).and_return('2')
#       allow(PaitinHangman::Levels).to receive(:new).and_return(nil)
#       expect(@player.select_level).to eql nil
#     end

#     it 'can start a level three game' do
#       allow(@player).to receive(:level_integrity).and_return('3')
#       allow(PaitinHangman::Levels).to receive(:new).and_return(nil)
#       expect(@player.select_level).to eql nil
#     end
#   end
# end
