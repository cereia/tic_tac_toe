# frozen_string_literal: true

require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

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

  describe '#verify_symbol' do
    subject(:board_verify_symbol) { described_class.new }

    context 'when user input is valid' do
      it 'returns valid input' do
        symbol_input = 'X'
        verified = board_verify_symbol.verify_symbol(symbol_input)
        expect(verified).to eql('X')
      end
    end

    context 'when user input is invalid' do
      it 'returns nil' do
        invalid = 'c'
        verified = board_verify_symbol.verify_symbol(invalid)
        expect(verified).to be_nil
      end
    end
  end

  describe '#place' do
    subject(:board_place) { described_class.new }

    before do
      board_place.instance_variable_set(:@player1, 'X')
      board_place.instance_variable_set(:@player2, 'O')
      board_place.instance_variable_set(:@round, 2)
      board_place.instance_variable_set(:@p1_positions, [1])
      board_place.instance_variable_set(:@p2_positions, [4])
      position = 3
      board_place.place(position)
    end

    it 'places the correct mark' do
      board = board_place.instance_variable_get(:@board)
      expect(board[2]).to eq('X')
    end

    it 'adds the new position to the correct player\'s positions' do
      p1_positions = board_place.instance_variable_get(:@p1_positions)
      expect(p1_positions).to eql([1, 3])
    end

    it 'does not change the other player\'s positions' do
      p2_positions = board_place.instance_variable_get(:@p2_positions)
      expect(p2_positions).to eql([4])
    end
  end
end

# rubocop:enable Metrics/BlockLength
