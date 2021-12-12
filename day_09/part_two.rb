input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)

matrix = strings.map do |str|
  str.split('').map do |n|
    {
      value: n.to_i,
      visited: false
    }
  end
end

max_x = matrix.first.length - 1
max_y = matrix.length - 1

low_points = []

neighbors_of = -> (x,y) do
  neighbors = []
  neighbors << [x-1, y] if x > 0
  neighbors << [x+1, y] if x < max_x
  neighbors << [x, y-1] if y > 0
  neighbors << [x, y+1] if y < max_y
  neighbors
end

matrix.each.with_index do |row, y|
  row.each.with_index do |cell, x|
    value = cell[:value]
    low_points << [x, y] if neighbors_of.(x, y).all? { |(x,y)| value < matrix[y][x][:value] }
  end
end

basin_value = -> (x,y) do
  return 0 if matrix[y][x][:value] == 9
  return 0 if matrix[y][x][:visited]

  matrix[y][x][:visited] = true

  1 + neighbors_of.(x, y).sum { |(x,y)| basin_value.(x,y) }
end

basin_values = low_points.map do |x, y|
  matrix.each { |row| row.each { |cell| cell[:visited] = false } }
  basin_value.(x, y)
end

puts basin_values.sort.last(3).inject(:*)
