# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  subject(:game) { described_class.new }
  let(:board) { double(Board) }

  # describe '#play_game' do
  #   context 'when a user inputs a yes input' do
  #     # before do
  #     # end

  #     it 'handles the start of a new game' do
  #       yes_input = 'y'
  #       allow(game).to receive(:player_answer).and_return(yes_input)
  #       allow(game).to receive(:create_board)
  #       allow(game).to receive(:place_mark)
  #       board = game.instance_variable_get(:@board)
  #       no_message = ':( No tic tac toe'

  #       game.play_game(no_message)
  #       expect(board).not_to be_nil
  #     end
  #   end
  # end

  # describe '#create_board' do
  #   it 'sets the @board variable to a new Board class instance' do
  #     allow(board).to receive(:new)
  #     game_board = game.instance_variable_get(:@board)
  #     game.create_board

  #     expect(game_board).not_to be_nil
  #   end
  # end

  describe '#player_answer' do
  end

  describe '#verify_confirmation_input' do
  end

  describe '#place_mark' do
  end

  describe '#verify_number_input' do
  end

  describe '#place_position' do
  end

  describe '#check_for_duplicate_positions' do
  end

  describe '#play_round' do
  end

  describe '#winner' do
  end

  describe '#win_positions' do
    context 'when the player has winning positions' do
      subject(:game_win_positions_winner) { described_class.new }
      let(:board_positions) { instance_double(Board) }

      it 'returns [3, 5, 7] given [5, 7, 1, 3, 6]' do
        positions = [5, 7, 1, 3, 6]
        expect(game_win_positions_winner.win_positions(positions)).to eq([3, 5, 7])
      end
    end

    context 'when the player does not have winning positions' do
      subject(:game_win_positions_nil) { described_class.new }
      let(:board_positions) { instance_double(Board) }

      it 'returns nil' do
        positions = [1, 2, 5]
        expect(game_win_positions_nil.win_positions(positions)).to be_nil
      end
    end
  end
end
