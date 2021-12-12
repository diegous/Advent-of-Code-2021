input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)
distances = strings.first.split(',').map(&:to_i)

costs = (0..distances.max).map do |n|
  distances.map { |i| (i - n).abs     }
           .sum { |i| i * (i + 1) / 2 }
end

puts costs.min
