class BingoBoard
  attr_accessor :rows

  def initialize(rows)
    @rows = rows[0..4].map { |row| row.split(' ') }
    @columns = @rows.transpose
  end

  def mark_number(n)
    @rows.each { |row| row.delete n }
    @columns.each { |column| column.delete n }
  end

  def won?
    @rows.any?(&:empty?) || @columns.any?(&:empty?)
  end
end

input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)
numbers_drawn = strings.first.split(',')

boards = strings[2..].each_slice(6).to_a.map { |arrs| BingoBoard.new(arrs) }
winner_board = nil

processed_boards = boards.map do |board|
  board_data = { board: board }

  numbers_drawn.each.with_index do |n, i|
    board.mark_number(n)
    next unless board.won?

    board_data[:winner] = n
    board_data[:index] = i
    break
  end

  board_data
end

loser = processed_boards.max_by { |data| data[:index] }

board_sum = loser[:board].rows.map { |row| row.map(&:to_i) }.map(&:sum).sum

puts "winner_number is #{loser[:winner]}, "   \
     "winner_board score is #{board_sum}, "     \
     "score is #{loser[:winner].to_i * board_sum}"
