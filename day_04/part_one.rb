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

winner_number = numbers_drawn.find do |n|
  boards.each { |board| board.mark_number(n) }
  winner_board = boards.find &:won?
  !winner_board.nil?
end

board_sum = winner_board.rows.map { |row| row.map(&:to_i) }.map(&:sum).sum

puts "winner_number is #{winner_number}, "   \
     "winner_board score is #{board_sum}, "     \
     "score is #{winner_number.to_i * board_sum}"
