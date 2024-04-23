# frozen_string_literal: true

# create a tic tac toe game where two humans can play
# the board is meant to be displayed in the console after every player turn
class Board
  attr_reader :board

  def initialize
    @board = []
    0.upto(8) { |i| @board[i] = '' }
    p board
  end

  def place(mark, position)
    if board[position - 1] == ''
      board[position - 1] = mark
    else
      puts 'There\'s already a symbol there. Please choose again.'
    end
    p board
  end
end

def play_game
  puts 'Would you like to play tic tac toe? Y/N'
  answer = gets
  if answer[0].match(/y/i)
    Board.new
  elsif answer[0].match(/n/i)
    puts ':( No tic tac toe'
  else
    puts 'Is that a yes or no?'
    play_game
  end
end

# run to start the game and create a board
play_game

{
  horizontal: [[1, 2, 3], [4, 5, 6], [7, 8, 9]],
  vertical: [[1, 4, 7], [2, 5, 8], [3, 6, 9]],
  diagonal: [[1, 5, 9], [3, 5, 7]]
}
