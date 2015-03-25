class Eightqueens
  Q = true
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @valid_board = Array.new(8) { Array.new(8, true) }
  end

  attr_accessor :board, :valid_board

  def valid_spot?(row,col)
    @valid_board[row][col]
  end



  def play
    puts "Choose which row to place queen:"
    row = gets.chomp.to_i
    puts row
    puts "Choose which column to place queen:"
    col = gets.chomp.to_i
    puts col
    place_queen(row, col) if valid_spot?(row, col)

    display_board
    if solved?
      puts "You win"
    else
      play
    end

    # query user again if game has not been won, play unless solved?
    # no more moves left if all spots on board are ineligible, end game
  end

  def place_queen(row, col)
    @board[row][col] = Q unless @board[row][col]
    invalidate_rows(row)
    invalidate_cols(col)
    invalidate_diags(row, col)
  end

  def invalidate_rows(row)
    (0..7).each do |i|
      @valid_board[row][i] = false
    end

  end

  def invalidate_cols(col)
    (0..7).each do |i|
      @valid_board[i][col] = false
    end

  end

  def invalidate_

  def display_board
    display = @board
    display.map do |row|
      row.map do |col|
        col ? "Q" : " "
      end
    end.each do |row|
      p row
    end

  end

  def solved?
    @board.each do |row|
      count = 0
      row.each do |col|
        count+=1 if col==true
      end
      return false unless count == 1
    end
    true
  end

end
