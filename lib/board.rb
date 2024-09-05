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
    mark = player_symbol
    board[position - 1] = mark
    mark == player1 ? p1_positions.push(position) : p2_positions.push(position)
    current_board
  end

  def player_symbol
    @round += 1
    round.odd? ? player1 : player2
  end

  def assign_symbol
    mark = symbol
    @player1 = mark.upcase
    @player2 = player1 == 'X' ? 'O' : 'X'
    puts "Player 1: #{player1}; Player 2: #{player2}\n\n"
  end

  def symbol
    loop do
      symbol = verify_symbol(player_symbol_input)
      return symbol if symbol

      puts 'Input Error!'
    end
  end

  def verify_symbol(symbol)
    symbol if symbol.match?(/^(x|o)$/i)
  end

  def current_board
    if round.zero?
      puts <<~HEREDOC

        #{print_board}
        --------------------Board Created--------------------

      HEREDOC
    else
      puts <<~HEREDOC
        #{print_board}
        --------------------End of round #{round}--------------------


      HEREDOC
    end
  end

  private

  def player_symbol_input
    puts 'Do you want to be X or O?'
    gets.chomp
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
end
