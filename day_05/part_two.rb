REGEX = /^(\d+),(\d+) -> (\d+),(\d+)$/

def draw_vertical(board, x, y1, y2)
  start, stop = [y1, y2].sort
  board[start..stop].each { |row| row[x] += 1 }
end

def draw_horizontal(board, y, x1, x2)
  start, stop = [x1, x2].sort
  (start..stop).each { |x| board[y][x] += 1 }
end

def draw_diagonal(board, x1, y1, x2, y2)
  x1, y1, x2, y2 = x2, y2, x1, y1 if x2 < x1

  x         = x1
  length    = x2 - x1
  start_y   = y1

  increment = y1 < y2 ? :upto : :downto

  y1.send(increment, y2).each do |y|
    board[y][x] += 1
    x += 1
  end
end

input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)
rects = strings.map { |str| REGEX.match(str).captures.map(&:to_i) }
size_x = rects.inject(0) { |max, (x1,_y1,x2,_y2)| [max, x1, x2].max }
size_y = rects.inject(0) { |max, (_x1,y1,_x2,y2)| [max, y1, y2].max }

board = Array.new(size_y + 1) { Array.new(size_x + 1, 0) }

rects.each do |(x1,y1,x2,y2)|
  if x1 == x2
    draw_vertical(board, x1, y1, y2)
  elsif y1 == y2
    draw_horizontal(board, y1, x1, x2)
  else
    draw_diagonal(board, x1, y1, x2, y2)
  end
end

sum = board.map { |row| row.count { |n| n > 1 } }.sum
puts "sum: #{sum}"
