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
      p board
    else
      puts 'There\'s already a symbol there. Please choose again.'
    end
  end
end

a = Board.new
a.place('X', 3)
a.place('O', 5)
a.place('X', 5)

{
  horizontal: [[1, 2, 3], [4, 5, 6], [7, 8, 9]],
  vertical: [[1, 4, 7], [2, 5, 8], [3, 6, 9]],
  diagonal: [[1, 5, 9], [3, 5, 7]]
}
