input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)

state = strings.first.split(',').map(&:to_i)

80.times do
  new_states = 0

  (0...state.length).each do |i|
    state[i] -= 1
    next unless state[i] < 0

    new_states += 1
    state[i] = 6
  end

  state += Array.new(new_states, 8)
end

puts state.count
