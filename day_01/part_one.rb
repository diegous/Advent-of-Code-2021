current = -1 # out of bound, all input numbers are positive
counter = -1 # first line will always be greater than -1 (first 'current' value)
input_path = ARGV[0]

File.open(input_path, 'r').each_line do |line|
  last = current
  current = line.to_i

  counter += 1 if current > last
end

puts counter
