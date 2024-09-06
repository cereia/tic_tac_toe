# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'

describe Game do
  describe '#play_game' do
    subject(:game_start) { described_class.new }

    before do
      allow(game_start).to receive(:create_board)
      allow(game_start).to receive(:place_mark)
    end

    context 'when a user inputs a yes input' do
      before do
        yes_input = 'y'
        allow(game_start).to receive(:player_answer).and_return(yes_input)
      end

      it 'starts a new game of tic tac toe' do
        expect(game_start).not_to receive(:puts)
        game_start.play_game
      end
    end

    context 'when a user inputs a no input' do
      before do
        no_input = 'n'
        allow(game_start).to receive(:player_answer).and_return(no_input)
      end

      it 'puts a message to the console and exits' do
        expect(game_start).to receive(:puts)
        game_start.play_game
      end
    end
  end

  describe '#create_board' do
    subject(:game_create_board) { described_class.new }

    it 'creates a new Board object' do
      expect(Board).to receive(:new)
      game_create_board.create_board
    end
  end

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
    context 'when one player has winning positions' do
      subject(:game_winner) { described_class.new }

      before do
        game_winner.instance_variable_set(:@board,
                                          instance_double(Board, p1_positions: [1, 5, 9], p2_positions: [3, 4]))

        allow(game_winner).to receive(:win_positions)
      end

      xit 'returns the array of winning positions' do
        winner = game_winner.winner
        expect(winner).to eql([1, 5, 9])
      end
    end

    context 'when neither player has winning positions' do
      subject(:game_no_winner) { described_class.new }
      before do
        game_no_winner.instance_variable_set(:@board,
                                             instance_double(Board, p1_positions: [5, 9], p2_positions: [3, 4]))

        allow(game_no_winner).to receive(:win_positions)
      end

      xit 'returns nil' do
        winner = game_no_winner.winner
        expect(winner).to be_nil
      end
    end
  end

  describe '#win_positions' do
    context 'when the player has winning positions' do
      subject(:game_win_positions_winner) { described_class.new }

      it 'returns [3, 5, 7] given [5, 7, 1, 3, 6]' do
        positions = [5, 7, 1, 3, 6]
        win_pos = game_win_positions_winner.win_positions(positions)
        expect(win_pos).to eq([3, 5, 7])
      end
    end

    context 'when the player does not have winning positions' do
      subject(:game_win_positions_nil) { described_class.new }

      it 'returns nil' do
        positions = [1, 2, 5]
        win_pos = game_win_positions_nil.win_positions(positions)
        expect(win_pos).to be_nil
      end
    end
  end
end
