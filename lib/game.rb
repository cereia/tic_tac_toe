# frozen_string_literal: true

# game class that holds all the methods to run a game of Tic Tac Toe
class Game
  WINS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

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
    win_position_array = player1 unless player1.flatten.empty?
    win_position_array = player2 unless player2.flatten.empty?
    winner = 'Player1' if win_position_array == player1
    winner = 'Player2' if win_position_array == player2

    return if winner.nil?

    puts "#{winner} won at #{win_position_array.flatten!}!"
    win_position_array
  end

  # find and return the winning positions
  def win_positions(player_position)
    # returns the array that contains all elements of one of the WINS arrays that match the player's positions
    WINS.select { |win| win.all? { |pos| win.count(pos) <= player_position.count(pos) } }
  end
end
