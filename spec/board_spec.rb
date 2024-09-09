# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#assign_symbol' do
    subject(:board_assign_symbol) { described_class.new }

    before do
      valid_input = 'x'
      allow(board_assign_symbol).to receive(:symbol).and_return(valid_input)
    end

    it 'sets @player1 to the user input, X in this case' do
      board_assign_symbol.assign_symbol

      p1 = board_assign_symbol.instance_variable_get(:@player1)
      expect(p1).to eql('X')
    end

    it 'sets @player2 to O' do
      board_assign_symbol.assign_symbol

      p2 = board_assign_symbol.instance_variable_get(:@player2)
      expect(p2).to eql('O')
    end

    it 'prints a message to the console indicating the player symbols' do
      expect(board_assign_symbol).to receive(:puts).with("Player 1: X; Player 2: O\n\n")
      board_assign_symbol.assign_symbol
    end
  end
end
