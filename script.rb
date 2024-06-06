# frozen_string_literal: true

# create a tic tac toe game where two humans can play on the command line
# the board is meant to be displayed in the console after every player turn
module TicTacToe
  WINS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  # board class to deal with the board's creation and methods that change the board
  class Board
    attr_reader :board, :round, :player1, :player2, :player1_positions, :player2_positions

    def initialize
      @board = []
      0.upto(8) { |i| board[i] = i + 1 }
      @round = 0
      @player1_positions = []
      @player2_positions = []
      assign_symbol
      current_board
    end

    def place(position)
      if board[position - 1].instance_of?(Integer)
        mark = inc_round_and_return_player_symbol
        board[position - 1] = mark
        mark == player1 ? player1_positions.push(position) : player2_positions.push(position)
      else
        puts "#{position} is not a free space. Please choose again."
      end
      current_board
    end

    def print_board
      row1 = board[0..2]
      row2 = board[3..5]
      row3 = board[6..]
      rows = [print_col_setup(row1), print_col_setup(row2), print_col_setup(row3)]
      puts rows.join("\n----------\n")
    end

    def print_col_setup(row)
      row.join(' | ')
    end

    private

    def current_board
      if round.zero?
        puts 'Board created:'
        print_board
        puts '--------------------Board Created--------------------'
      else
        puts "Round: #{round}"
        print_board
        puts "--------------------End of round #{round}--------------------"
      end
    end

    def assign_symbol
      puts 'Do you want to be X or O?'
      mark = gets.chomp
      if mark.match?(/x|o/i) && mark.length == 1
        @player1 = mark.upcase
        @player2 = player1 == 'X' ? 'O' : 'X'
        puts "Player 1: #{player1}; Player 2: #{player2}"
      else
        assign_symbol
      end
    end

    def inc_round_and_return_player_symbol
      @round += 1
      round.odd? ? player1 : player2
    end
  end

  # game class that holds all the methods to run a game of Tic Tac Toe
  class Game
    def initialize
      @game_board = nil
      play_game
    end

    private

    def play_game
      puts 'Would you like to play tic tac toe? Y/N'
      input_checker(':( No tic tac toe', method(:play_game))
    end

    def restart
      puts 'Would you like to play again? Y/N'
      input_checker('Thank you for playing :)', method(:restart))
    end

    def input_checker(no_return, method)
      answer = gets.chomp
      if answer.match?(/y/i)
        @game_board = Board.new
        check_position_input
      elsif answer.match?(/n/i)
        puts no_return
      else
        method.call
      end
    end

    def check_position_input
      puts "It is #{(@game_board.round + 1).odd? ? @game_board.player1 : @game_board.player2}'s turn."
      puts 'Please choose a number from 1 to 9.'
      num = gets.chomp
      if num.match?(/[1-9]/) && num.length == 1
        @game_board.place(num.to_i)
        play_round
      else
        check_position_input
      end
    end

    def play_round
      if @game_board.round < 5
        check_position_input
      elsif @game_board.round < 9
        winner? == false ? check_position_input : restart
      else
        puts 'There was a draw :('
        restart
      end
    end

    # returns true/false if player1 or player2 is the winner
    def winner?
      player1 = any_empty?(@game_board.player1_positions)
      player2 = any_empty?(@game_board.player2_positions)
      winner = 'Player1' if player1
      winner = 'Player2' if player2

      unless winner.nil?
        win = win_positions(winner)
        puts "#{winner} won at #{win}!"
      end

      player1 == true || player2 == true
    end

    def array_subtraction(player_positions)
      WINS.map { |win| (win - player_positions) }
    end

    # get the index of the empty array
    # an empty array means there is a winner, so you want to grab that empty array's index
    # to display positions that won the game
    def empty_index(subtracted_arr)
      i = 0
      while i < subtracted_arr.length - 1
        return i if subtracted_arr[i].empty?

        i += 1
      end
      i
    end

    def win_positions(winner)
      sub_arr = if winner == 'Player1'
                  array_subtraction(@game_board.player1_positions)
                else
                  array_subtraction(@game_board.player2_positions)
                end
      index = empty_index(sub_arr)
      WINS[index]
    end

    # map empty checks if these subtracted arrays are empty (returns array of true/false)
    # any checks if there is a true in the true/false array (returns 1 true/false)
    def any_empty?(player_positions)
      subtracted_arr = array_subtraction(player_positions)
      subtracted_arr.map(&:empty?).any?
    end
  end
end

# run to start the game
TicTacToe::Game.new
