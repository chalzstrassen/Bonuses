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

  def invalidate_diags(row,col)
    # go southeast [+1,+1]
    invalidate_left_down(row, col)
    invalidate_left_up(row, col)

  end

  def invalidate_left_down(row, col)
    unless row == 7
      ((row+1)..7).each do |row|
        col+=1
        @valid_board[row][col] = false if col <= 7
      end
    end

  end

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
