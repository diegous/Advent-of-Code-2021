#   0:      1:      2:      3:      4:
#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....
# 6       2       5       5       4

#   5:      6:      7:      8:      9:
#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg
# 5       6       3       7       6

# segment count | n
#        2      | 1
#        3      | 7
#        4      | 4
#        5      | 2, 3, 5
#        6      | 0, 6, 9
#        7      | 8

input_path = ARGV[0]
strings = File.readlines(input_path, chomp: true)

digits_list = strings.map { |str| str.scan(/\w+/) }

output_numbers = digits_list.map do |digits|
  # Sorting the digits make comparing them easier later
  digits.map! { |digit| digit.split('') }.map!(&:sort)

  output = digits.slice!(-4, 4)
  by_length = digits.group_by(&:length)

  found = [
    nil,                # 0
    by_length[2].first, # 1
    nil,                # 2
    nil,                # 3
    by_length[4].first, # 4
    nil,                # 5
    nil,                # 6
    by_length[3].first, # 7
    by_length[7].first, # 8
    nil                 # 9
  ]

  # 3 is similar to 7
  found[3] = by_length[5].find { |chars| (found[7] - chars).empty? }
  by_length[5].delete(found[3])

  # 9 is similar to 3
  found[9] = by_length[6].find { |chars| (found[3] - chars).empty? }
  by_length[6].delete(found[9])

  # 5 is similar to 9
  found[5] = by_length[5].find { |chars| (chars - found[9]).empty? }
  by_length[5].delete(found[5])

  # 2 is the only one left from the lengt-5 group
  found[2] = by_length[5].first

  # 6 is similar to 5
  found[6] = by_length[6].find { |chars| (found[5] - chars).empty? }
  by_length[6].delete(found[6])

  # 2 is the only one left from the lengt-6 group
  found[0] = by_length[6].first

  found.map! &:join
  output.map! &:join

  output.map { |digit| found.index(digit) }
        .map(&:to_s)
        .join
        .to_i
end

puts output_numbers.sum
