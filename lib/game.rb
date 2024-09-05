# frozen_string_literal: true

# game class that holds all the methods to run a game of Tic Tac Toe
class Game
  WINS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  def initialize
    @game_board = nil
    play_game(':( No tic tac toe')
  end

  private

  def play_game(no_return)
    answer = verify_confirmation_input

    if answer.match?(/y/i)
      create_board
      place_mark
    else
      puts no_return
    end
  end

  def create_board
    @game_board = Board.new
  end

  def verify_confirmation_input
    loop do
      puts @game_board.nil? ? 'Would you like to play tic tac toe? Y/N' : 'Would you like to play again? Y/N'
      answer = gets.chomp
      return answer if answer.match?(/y|n/i)
    end
  end

  def place_mark
    puts "It is #{(@game_board.round + 1).odd? ? @game_board.player1 : @game_board.player2}'s turn."
    num = verify_number_input
    @game_board.place(num.to_i)
    play_round
  end

  def verify_number_input
    loop do
      puts 'Please choose a number from 1 to 9.'
      num = gets.chomp
      return num if num.match?(/^[1-9]$/)
    end
  end

  def play_round
    if @game_board.round < 5
      place_mark
    elsif @game_board.round < 9
      # starting at round 5, check if there is a winner
      winner.nil? ? place_mark : play_game('Thank you for playing :)')
    else
      puts 'There was a draw :('
      play_game('Thank you for playing :)')
    end
  end

  # returns the win position and the winner if a winning position array is found/win has a value
  def winner
    player1 = win_positions(@game_board.p1_positions)
    player2 = win_positions(@game_board.p2_positions)
    return if player1.nil? && player2.nil?

    win_position_array = player1 || player2
    winner = player1 ? 'Player1' : 'Player2'

    puts "#{winner} won at #{win_position_array.flatten!}!"
    win_position_array
  end

  # find and return the winning positions
  def win_positions(player_position)
    # returns the array that contains all elements of one of the WINS arrays that match the player's positions
    # returns nil if winning positions are not found
    positions = WINS.select { |win| win.all? { |pos| win.count(pos) <= player_position.count(pos) } }
    positions unless positions.flatten.empty?
  end
end
