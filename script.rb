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
      0.upto(8) { |i| board[i] = '' }
      @round = 0
      @player1_positions = []
      @player2_positions = []
      assign_symbol
      puts "Board created: #{board}"
    end

    def place(position)
      if board[position - 1] == ''
        inc_round
        mark = which_mark
        board[position - 1] = mark
        position_recorder(mark, position)
      else
        puts "There's already an #{board[position - 1]} at #{position}. Please choose again."
      end
      puts "Round: #{round} #{board}"
    end

    private

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
      answer = gets.chomp
      play_game unless answer[0].match(/y|n/i)
      if answer[0].match(/y/i)
        board = Board.new
        play_round(board)
      elsif answer[0].match(/n/i)
        puts ':( No tic tac toe'
      end
    end

    def play_round(game_board)
      puts 'Please choose a number from 1 to 9.'
      num = gets.chomp
      if num.match(/[1-9]/) && num.length == 1
        game_board.place(num.to_i)
        check_for_winner(game_board)
      else
        play_round(game_board)
      end
    end

    def check_for_winner(game_board)
      if game_board.round < 5
        play_round(game_board)
      elsif game_board.round < 9
        winner?(game_board) == false ? play_round(game_board) : restart
      else
        puts 'There was a draw :('
        restart
      end
    end

    def winner?(game_board)
      player1 = check_positions_for_win(game_board.player1_positions)
      player2 = check_positions_for_win(game_board.player2_positions)
      if player1
        puts "Player1 (#{game_board.player1}) won!"
      elsif player2
        puts "Player2 (#{game_board.player2}) won!"
      end
      player1 == true || player2 == true
    end

    def check_positions_for_win(player_positions)
      WINS.map { |win| (win - player_positions).empty? }.any?
    end

    def restart
      puts 'Would you like to play again? Y/N'
      answer = gets.chomp
      if answer[0].match(/y/i)
        board = Board.new
        play_round(board)
      else
        puts 'Thank you for playing :)'
      end
    end
  end
end

# run to start the game
TicTacToe::Game.new.play_game
