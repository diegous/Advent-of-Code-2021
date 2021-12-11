input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)
state = strings.first.split(',').map(&:to_i)

amount_per_timer = Array.new(9, 0)

state.each { |timer| amount_per_timer[timer] += 1 }

256.times do
  amount_per_timer.rotate!
  amount_per_timer[6] += amount_per_timer[8]
end

puts amount_per_timer.sum
