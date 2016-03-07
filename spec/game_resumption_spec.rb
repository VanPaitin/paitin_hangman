# require 'spec_helper'

# describe "PaitinHangman::GameResumption" do
  
# end

# describe PaitinHangman::GameResumption do
#   before :each do
#     @instance = PaitinHangman::GameResumption.new
#   end

#   describe '#new' do
#     it 'returns a new game object' do
#       expect(@instance).to be_a PaitinHangman::Saved
#     end

#     it 'throws an error when instantiated with less than seven parameters' do
#       expect{PaitinHangman::Saved.new "lala", "in the mighty"}.to raise_error ArgumentError
#     end
#   end

#   describe '#trials' do
#     it 'can run a resmed game successfully' do
#       allow(@instance).to receive(:verify_guess).and_return(nil)
#       allow(@instance).to receive(:compare_guess).and_return(nil)
#       allow(@instance).to receive(:win_game).and_return(nil)
#       allow(@instance).to receive(:end_game).and_return(nil)
#       expect(@instance.trials(10)).to eql nil
#     end
#   end
# end