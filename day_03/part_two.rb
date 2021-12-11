input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)

def split_by_bit(arr, nbit)
  by_bits = { '0' => [], '1' => [] }
  arr.each { |str| by_bits[str[nbit]] << str }

  [by_bits['0'], by_bits['1']]
end

def find_by_operator(operator, array, nbit)
  zeroes, ones = split_by_bit(array, nbit)

  # This translates to `ones.count >= zeroes.count`
  # or                 `ones.count <  zeroes.count`
  relevant_group = if ones.count.send(operator, zeroes.count)
                     ones
                   else
                     zeroes
                   end

  return relevant_group.first if relevant_group.one?

  find_by_operator(operator, relevant_group, nbit + 1) # tail call optimization?
end

oxygen_b   = find_by_operator(:>=, strings, 0)
scrubber_b = find_by_operator(:<, strings, 0)

oxygen   = oxygen_b.to_i(2)
scrubber = scrubber_b.to_i(2)

puts "Oxygen is #{oxygen}, "         \
     "CO2 scrubber is #{scrubber}, " \
     "life support rating is #{oxygen * scrubber}"
