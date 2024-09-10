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

  describe '#symbol' do
    subject(:board_symbol) { described_class.new }

    context 'when the user inputs a valid input' do
      before do
        valid_input = 'x'
        allow(board_symbol).to receive(:player_symbol_input).and_return(valid_input)
      end

      it 'returns valid input' do
        returned_symbol = board_symbol.symbol
        expect(returned_symbol).to eql('x')
      end
    end

    context 'when the user inputs an invalid input and a valid input' do
      before do
        invalid_input = '*'
        valid_input = 'o'
        allow(board_symbol).to receive(:player_symbol_input).and_return(invalid_input, valid_input)
      end

      it 'completes a loop and displays the error message' do
        expect(board_symbol).to receive(:puts).with('Input Error!')
        board_symbol.symbol
      end
    end
  end
end
