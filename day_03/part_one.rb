input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)
counter = Array.new(strings.first.length, 0)

strings.each do |str|
  str.chars.each.with_index { |d,i| counter[i] += 1 if d == '1' }
end

gamma_b = ''
epsilon_b = ''
threshold = strings.length / 2

counter.each do |count|
  if count > threshold
    gamma_b   += '1'
    epsilon_b += '0'
  else
    gamma_b   += '0'
    epsilon_b += '1'
  end
end

gamma = gamma_b.to_i(2)
epsilon = epsilon_b.to_i(2)

puts "gamma is #{gamma} (#{gamma_b}), "       \
     "epsilon is #{epsilon} (#{epsilon_b}), " \
     "product is #{gamma * epsilon}"
