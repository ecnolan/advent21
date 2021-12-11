#!/usr/bin/ruby

class Cell
   def initialize(num)
      @num = num
      @marked = false
   end
   attr_reader :num
   attr_reader :marked
   attr_writer :marked

   def to_s
      return "#{@num}#{(@marked ? '*' : '')} "
   end

   def to_i
     return @num.to_i
   end

   def mark num
      # set the mark on this cell to true if its num equals the
      # parameter num
      if num == @num
         @marked = true
      end
   end
end


class Board
   def initialize(numbers)
      # numbers is an array consisting of 25 numbers for a bingo board,
      # in row major order.
      @grid = []
      curr = 0
      for row in 0...5
         thisrow = []
         for col in 0...5
            thisrow.append (Cell.new(numbers[curr]))
            curr += 1
         end
         @grid.append thisrow
      end
   end

   def to_s
      result = ""
      for r in 0...5
         for c in 0...5
            result += @grid[r][c].to_s
         end
         result += "\n"
      end
      result += "\n"
      return result
   end

   def mark(num)
      # mark each cell in the grid
      @grid.each {|row| row.each {|cell| cell.mark(num) } }
   end

   def has_won
      # check row win
      for r in 0...5
        won = true
        for c in 0...5
          if @grid[r][c].to_s[-2] != "*"
            won = false
          end
        end
        if won
          return won
        end
      end

      # check column win
      for c in 0...5
        won = true
        for r in 0...5
          if @grid[r][c].to_s[-2] != "*"
            won = false
          end
        end
        if won
          return won
        end
      end
      return won
   end

   def score num
     tot = 0
     for c in 0...5
       for r in 0...5
         if @grid[r][c].to_s[-2] != "*"
            tot = tot + @grid[r][c].to_i
         end
       end
     end
     return tot * num.to_i
   end
end


# The main script is here.
# Get the input
data = STDIN.read

# Divide the input into its pieces.
numbers = []
boards = []


# PUT YOUR IMPLEMENTATION HERE
# Get numbers
# p "getting numbers"
numspat = /(\d+,)+(\d)+\n/
mnums = numspat.match(data)
boardsdata = mnums.post_match
mnums = mnums[0]
digpat = /(\d+)/
while (mnums != "")
  m = digpat.match(mnums)
  if m
    numbers << "#{m}"
    mnums = m.post_match
  else
    mnums = ""
  end
end

#Get boards
aboardpat = /(\d+ +){4}(\d+)\n{5}/
digpat = /(\d+)/
while (digpat.match(boardsdata))
  boardnums = []
  while (boardnums.length != 25)
    m = digpat.match(boardsdata)
    if m
      boardnums << "#{m}"
      boardsdata = m.post_match
    else
      boardsdata = ""
    end
  end
  myboard = Board.new(boardnums)
  boards << myboard
end

# numbers is now an array of numbers to be called;
# boards is now an array of properly initialized board objects.

# The remainder of the script is provided for you.
winner = false
winning_num = 0
for num in numbers
   break if winner      # exit outer loop if a winner has already been found
   for board in boards  # inner loop
      board.mark(num)
      if board.has_won
        winner = board  # remember the winning board
        winning_num = num  # and the number that was called
        break
      end
   end
end

# Output the winning board and its score
puts winner
puts winner.score(winning_num)
