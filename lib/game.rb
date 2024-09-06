# frozen_string_literal: true

# game class that holds all the methods to run a game of Tic Tac Toe
class Game
  attr_reader :board

  WINS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  def initialize
    @board = nil
  end

  def play_game(no_return = ':( No tic tac toe')
    answer = player_answer

    if answer.match?(/y/i)
      @position_history = []
      create_board
      place_mark
    else
      puts no_return
    end
  end

  def create_board
    @board = Board.new
  end

  def player_answer
    loop do
      answer = verify_confirmation_input(player_confirmation_input)
      return answer if answer

      puts 'Input Error!'
    end
  end

  def verify_confirmation_input(answer)
    answer if answer.match?(/y|n/i)
  end

  def place_mark
    puts "Round: #{@board.round + 1}\nIt is #{(@board.round + 1).odd? ? @board.player1 : @board.player2}'s turn."

    num = place_position
    @board.place(num)
    @position_history << num

    play_round
  end

  def verify_number_input(num)
    num.to_i if num.match?(/^[1-9]$/)
  end

  def place_position
    loop do
      num = verify_number_input(player_number_input)
      return num if check_for_duplicate_position(num)

      puts 'Input Error!'
    end
  end

  def check_for_duplicate_position(position)
    return position unless @position_history.include?(position)

    puts "#{position} is not a free space. Please choose again."
    @board.current_board
  end

  def play_round
    if @board.round < 5
      place_mark
    elsif @board.round < 9
      # starting at round 5, check if there is a winner
      winner.nil? ? place_mark : play_game('Thank you for playing :)')
    else
      puts 'There was a draw :('
      play_game('Thank you for playing :)')
    end
  end

  # returns the win position and the winner if a winning position array is found/win has a value
  def winner
    player1 = win_positions(@board.p1_positions)
    player2 = win_positions(@board.p2_positions)
    return if player1.nil? && player2.nil?

    win_position_array = player1 || player2
    winner = player1 ? 'Player1' : 'Player2'

    puts "#{winner} won at #{win_position_array}!"
    win_position_array
  end

  # find and return the winning positions
  def win_positions(player_position)
    # returns the array that contains all elements of one of the WINS arrays that match the player's positions
    # returns nil if winning positions are not found
    positions = WINS.select { |win| win.all? { |pos| win.count(pos) <= player_position.count(pos) } }
    positions.flatten unless positions.flatten.empty?
  end

  private

  def player_confirmation_input
    puts @board.nil? ? 'Would you like to play tic tac toe? Y/N' : 'Would you like to play again? Y/N'
    gets.chomp
  end

  def player_number_input
    puts 'Please choose a number from 1 to 9.'
    gets.chomp
  end
end
