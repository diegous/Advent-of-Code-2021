input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)

matrix = strings.map { |str| str.split('').map(&:to_i) }
max_x = matrix.first.length - 1
max_y = matrix.length - 1

low_point_values = []

matrix.each.with_index do |row, y|
  row.each.with_index do |value, x|
    next if x > 0     && value >= matrix[y][x-1]
    next if x < max_x && value >= matrix[y][x+1]
    next if y > 0     && value >= matrix[y-1][x]
    next if y < max_y && value >= matrix[y+1][x]
    low_point_values << value
  end
end

# pp low_point_values
puts low_point_values.sum + low_point_values.count
