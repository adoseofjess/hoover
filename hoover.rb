class Hoover
  COORDINATES = {"N" => [0,1], "S" => [0,-1], "W" => [-1,0], "E" => [1,0]}

  attr_accessor :room_dimensions, :hoover_position, :dirt_patches, :directions, :count_of_dirt_patches

  def initialize(filename)
    my_array = IO.readlines(filename).map(&:strip)
    @directions = my_array.pop.split("")
    my_array.map!{|coordinates| coordinates.split(" ").map(&:to_i) }
    @room_dimensions = my_array.shift
    @hoover_position = my_array.shift
    @dirt_patches = my_array
    @count_of_dirt_patches = 0
  end

  def run
    @directions.each do |direction|
      self.transform(COORDINATES[direction])

      if @dirt_patches.include?(@hoover_position)
        @count_of_dirt_patches += @dirt_patches.count(@hoover_position)
        @dirt_patches.delete(@hoover_position)
      end
    end

    print_results(count_of_dirt_patches)
  end

  def transform(direction)
    @hoover_position.each_with_index do |coordinate, index|
      new_position = coordinate += direction[index]

      if new_position >= 0 && new_position <= @room_dimensions[index]
        @hoover_position[index] = new_position
      else
        # p "Can't go beyond room boundary of #{@room_dimensions}: invalid position of #{new_position}"
      end
    end
  end

  def print_results(count_of_dirt_patches)
    print "#{@hoover_position.join(" ")}\n"
    print "#{count_of_dirt_patches}\n"
  end
end

hoover = Hoover.new("input.txt")
hoover.run