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

outputs = strings.map { |str| str.split('|').last.split(' ') }
total = outputs.map do |line|
  line.count { |str| [2,3,4,7].include? str.length }
end.sum

puts total
