# frozen_string_literal: true

# create a tic tac toe game where two humans can play on the command line
# the board is meant to be displayed in the console after every player turn
module TicTacToe
  WINS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  # board class to deal with the board's creation and methods that change the board
  class Board
    attr_reader :board, :round, :player1, :player2, :p1_positions, :p2_positions

    def initialize
      @board = []
      0.upto(8) { |i| board[i] = i + 1 }
      @round = 0
      @p1_positions = []
      @p2_positions = []
      assign_symbol
      current_board
    end

    def place(position)
      if board[position - 1].instance_of?(Integer)
        mark = inc_round_and_return_player_symbol
        board[position - 1] = mark
        mark == player1 ? p1_positions.push(position) : p2_positions.push(position)
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
        # starting at round 5, check if there is a winner
        winner.nil? ? check_position_input : restart
      else
        puts 'There was a draw :('
        restart
      end
    end

    # returns the win position and the winner if a winning position array is found/win has a value
    def winner
      player1 = win_positions(@game_board.p1_positions)
      player2 = win_positions(@game_board.p2_positions)
      win = player1 unless player1.flatten.empty?
      win = player2 unless player2.flatten.empty?
      winner = 'Player1' if win == player1
      winner = 'Player2' if win == player2

      return if win.nil?

      puts "#{winner} won at #{win.flatten!}!"
      win
    end

    # find and return the winning positions
    def win_positions(player_position)
      WINS.select { |win| win.all? { |pos| win.count(pos) <= player_position.count(pos) } }
    end
  end
end

# run to start the game
TicTacToe::Game.new
