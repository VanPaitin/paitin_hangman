require 'spec_helper'

describe PaitinHangman::Levels do 
  
  describe '#initialize_specs' do
  end

  describe '#word_generator' do
  end

  describe '#challenge_word' do
    @level.instance_variable_set("@player1", "Mayowa")
    specify { expect { @level.challenge_word }.to output("Now, enter your challenge_word #{@player1}, it will be hidden").to_stdout }
    allow(STDIN.noecho).to receive(:gets)


  end

  describe '#trials' do
    allow(@level).to receive(:verify_guess).and_return('f')


  end

  describe '#end_game' do
    context 'can print something to the screen' do
      
end 