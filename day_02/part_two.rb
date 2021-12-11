class Position
  attr_accessor :x, :y, :aim

  def initialize
    @x, @y, @aim = [0,0,0]
  end

  def forward(n)
    @x += n
    @y += n * @aim
  end

  def down(n)
    @aim -= n
  end

  def up(n)
    @aim += n
  end

  def to_s
    "(#{@x},#{@y})"
  end
end

input_path = ARGV[0]
lines = File.readlines(input_path)
directions = lines.map { |l| l.split ' ' }

position = Position.new
directions.each { |direction, n| position.send(direction, n.to_i) }

puts "Total is #{position.x * position.y * -1} (Position #{position})"
