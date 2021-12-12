input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)
distances = strings.first.split(',').map(&:to_i)

costs = distances.map do |n|
  distances.sum { |i| (i - n).abs }
end

puts costs.min
