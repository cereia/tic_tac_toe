# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'

# rubocop:disable Metrics/BlockLength

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
    subject(:game_loop_answer) { described_class.new }

    context 'when the user input is valid' do
      before do
        valid_input = 'y'
        allow(game_loop_answer).to receive(:player_confirmation_input).and_return(valid_input)
      end

      it 'stops the loop and does not display the error message' do
        expect(game_loop_answer).not_to receive(:puts).with('Input Error!')
        game_loop_answer.player_answer
      end

      it 'returns valid input' do
        expect(game_loop_answer.player_answer).not_to be_nil
      end
    end

    context 'when the user inputs an invalid value, and then a valid one' do
      before do
        invalid = 'e'
        valid = 'n'
        allow(game_loop_answer).to receive(:player_confirmation_input).and_return(invalid, valid)
      end

      it 'completes a loop and displays the error message' do
        expect(game_loop_answer).to receive(:puts).with('Input Error!').once
        game_loop_answer.player_answer
      end
    end
  end

  describe '#verify_confirmation_input' do
    subject(:game_verify_confirmation) { described_class.new }

    context 'when a user inputs a valid input' do
      it 'returns valid input' do
        user_input = 'n'
        verified_input = game_verify_confirmation.verify_confirmation_input(user_input)
        expect(verified_input).to eq('n')
      end
    end

    context 'when a user inputs an invalid input' do
      it 'returns nil' do
        user_input = 'x'
        verified_input = game_verify_confirmation.verify_confirmation_input(user_input)
        expect(verified_input).to be_nil
      end
    end
  end

  describe '#verify_number_input' do
    subject(:game_verify_number) { described_class.new }

    context 'when a user inputs a valid input' do
      it 'returns valid input' do
        user_input = '4'
        verified_input = game_verify_number.verify_number_input(user_input)
        expect(verified_input).to eq(4)
      end
    end

    context 'when a user inputs an invalid input' do
      it 'returns nil' do
        user_input = '66'
        verified_input = game_verify_number.verify_number_input(user_input)
        expect(verified_input).to be_nil
      end
    end
  end

  describe '#place_position' do
    subject(:game_loop_position) { described_class.new }
    before do
      game_loop_position.instance_variable_set(:@position_history, [1, 2])
    end

    context 'when the user input is valid' do
      before do
        valid_input = '4'
        allow(game_loop_position).to receive(:player_number_input).and_return(valid_input)
      end

      it 'stops the loop and does not display the error message' do
        expect(game_loop_position).not_to receive(:puts).with('Input Error!')
        game_loop_position.place_position
      end

      it 'returns valid input' do
        expect(game_loop_position.place_position).not_to be_nil
      end
    end

    context 'when the user inputs an invalid value, and then a valid one' do
      before do
        invalid = 'e'
        valid = '7'
        allow(game_loop_position).to receive(:player_number_input).and_return(invalid, valid)
      end

      it 'completes a loop and displays the error message' do
        expect(game_loop_position).to receive(:puts).with('Input Error!').once
        game_loop_position.place_position
      end
    end
  end

  describe '#check_for_duplicate_position' do
    subject(:game_check_for_dups) { described_class.new }
    let(:board_check_for_dups) { instance_double(Board) }

    before do
      game_check_for_dups.instance_variable_set(:@position_history, [4])
      game_check_for_dups.instance_variable_set(:@board, board_check_for_dups)
      allow(board_check_for_dups).to receive(:current_board)
    end

    context 'when a user inputs a unique value' do
      it 'returns the unique value' do
        unique_value = 7
        position = game_check_for_dups.check_for_duplicate_position(unique_value)
        expect(position).to eql(unique_value)
      end
    end

    context 'when a user inputs a duplicate value' do
      it 'returns nil' do
        duplicate_value = 4
        position = game_check_for_dups.check_for_duplicate_position(duplicate_value)
        expect(position).to be_nil
      end
    end
  end

  describe '#winner' do
    context 'when one player has winning positions' do
      subject(:game_winner) { described_class.new }
      let(:board_winner) { instance_double(Board, p1_positions: [1, 5, 9], p2_positions: [2, 3]) }
      before do
        game_winner.instance_variable_set(:@board, board_winner)
      end

      it 'takes the board\'s p1_positions to pass into #win_positions' do
        expect(board_winner).to receive(:p1_positions)
        game_winner.winner
      end

      it 'takes the board\'s p2_positions to pass into #win_positions' do
        expect(board_winner).to receive(:p2_positions)
        game_winner.winner
      end

      it 'calls win_positions twice' do
        expect(game_winner).to receive(:win_positions).twice
        game_winner.winner
      end

      it 'puts a winning message to the console' do
        expect(game_winner).to receive(:puts)
        game_winner.winner
      end

      it 'returns the array of winning positions' do
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

      it 'returns nil' do
        winner = game_no_winner.winner
        expect(winner).to be_nil
      end

      it 'does not have a puts message indicating a winner' do
        expect(game_no_winner).not_to receive(:puts)
        game_no_winner.winner
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

  describe '#place_mark' do
    subject(:game_place_mark) { described_class.new }
    let(:board_place_mark) do
      instance_double(Board,
                      round: 2,
                      player1: 'X',
                      player2: 'O',
                      p1_positions: [1],
                      p2_positions: [6])
    end

    before do
      position = 3
      allow(game_place_mark).to receive(:place_position).and_return(position)
      game_place_mark.instance_variable_set(:@position_history, [1, 6])
      game_place_mark.instance_variable_set(:@board, board_place_mark)
      allow(board_place_mark).to receive(:place)
    end

    context 'places a mark' do
      it 'calls #place once' do
        expect(board_place_mark).to receive(:place).with(3).once
        game_place_mark.place_mark
      end

      it 'updates @position_history' do
        game_place_mark.place_mark
        history = game_place_mark.instance_variable_get(:@position_history)
        expect(history).to eql([1, 6, 3])
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
