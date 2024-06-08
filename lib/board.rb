# frozen_string_literal: true

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
