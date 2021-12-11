input_path = ARGV[0]
numbers = File.readlines(input_path).map(&:to_i)
sums = numbers.each_cons(3).map(&:sum)
increases = sums.each_cons(2).count { |n1, n2| n1 < n2 }

puts increases
