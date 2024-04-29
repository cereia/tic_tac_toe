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
        good_position(position)
      else
        bad_position(position)
      end
      current_board
    end

    def print_board
      puts "#{board[0..2]} \n#{board[3..5]} \n#{board[6..]}"
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

    def bad_position(position)
      puts "There's already an #{board[position - 1]} at #{position}. Please choose again."
    end

    def good_position(position)
      inc_round
      mark = which_mark
      board[position - 1] = mark
      position_recorder(mark, position)
    end

    def assign_symbol
      puts 'Do you want to be X or O?'
      mark = gets.chomp
      if mark.match(/x|o/i) && mark.length == 1
        @player1 = mark.match(/x|o/i).to_s.upcase
        @player2 = player1 == 'X' ? 'O' : 'X'
        puts "Player 1: #{player1}; Player 2: #{player2}"
      else
        assign_symbol
      end
    end

    def which_mark
      round.odd? ? player1 : player2
    end

    def inc_round
      @round += 1
    end

    def position_recorder(symbol, position)
      symbol == player1 ? player1_positions.push(position) : player2_positions.push(position)
    end
  end

  # game class that holds all the methods to run a game of Tic Tac Toe
  class Game
    def play_game
      puts 'Would you like to play tic tac toe? Y/N'
      input_checker(':( No tic tac toe', method(:play_game))
    end

    private

    def restart
      puts 'Would you like to play again? Y/N'
      input_checker('Thank you for playing :)', method(:restart))
    end

    def input_checker(no_return, method)
      answer = gets.chomp
      if answer[0].match(/y/i)
        create_board
      elsif answer[0].match(/n/i)
        puts no_return
      else
        method.call
      end
    end

    def position_input(game_board)
      whose_turn(game_board)
      puts 'Please choose a number from 1 to 9.'
      num = gets.chomp
      if num.match(/[1-9]/) && num.length == 1
        game_board.place(num.to_i)
        play_round(game_board)
      else
        position_input(game_board)
      end
    end

    def whose_turn(game_board)
      puts "It is #{(game_board.round + 1).odd? ? game_board.player1 : game_board.player2}'s turn."
    end

    def play_round(game_board)
      if game_board.round < 5
        position_input(game_board)
      elsif game_board.round < 9
        winner?(game_board) == false ? position_input(game_board) : restart
      else
        puts 'There was a draw :('
        restart
      end
    end

    def create_board
      board = Board.new
      position_input(board)
    end

    def winner?(game_board)
      player1 = any_empty?(game_board.player1_positions)
      player2 = any_empty?(game_board.player2_positions)

      winner = 'Player1' if player1
      winner = 'Player2' if player2
      display_win(game_board, winner) unless winner.nil?

      player1 == true || player2 == true
    end

    def display_win(game_board, winner)
      win = win_positions(game_board, winner)
      puts "#{winner} won at #{win}!"
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

    def win_positions(game_board, winner)
      sub_arr = if winner == 'Player1'
                  array_subtraction(game_board.player1_positions)
                else
                  array_subtraction(game_board.player2_positions)
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
TicTacToe::Game.new.play_game
