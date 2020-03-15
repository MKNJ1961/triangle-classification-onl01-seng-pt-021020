require 'set'

class Triangle

  attr_accessor :sides

  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3]
    @kind = set_kind
  end

  def check
    valid?
  end

  def kind
    raise TriangleError.new if !valid?

    @kind
  end

  # private

  def valid?
    return false if @sides.any?{|side| side <= 0}
    case @kind
    when Types.scalene
      return longest < @sides.reject{|side| side == longest}.reduce{|cum, cur| cum + cur}
    when Types.isosceles
      larger = @sides.reject{|side| side == smallest}
      puts larger.length
      puts smallest * 2
      return larger.length == 2 || smallest * 2 > larger[0]
    when Types.equilateral
      return true
    else
      puts "This should never be run"
    end
  end

  def set_kind
    case unique_sides
    when 1
      return Types.equilateral
    when 2
      return Types.isosceles
    when 3
      return Types.scalene
    else
      raise TraingleError
    end

  end

  def longest
    largest = 0
    @sides.each{|side| largest = side if side > largest}
    largest
  end

  def smallest
    smallest = Float::INFINITY
    @sides.each{|side| smallest = side if side < smallest}
    smallest
  end

  def unique_sides
    Set.new(@sides).size
  end

  class Types

    def self.isosceles
      :isosceles
    end

    def self.scalene
      :scalene
    end

    def self.equilateral
      :equilateral
    end

  end

  class TriangleError < StandardError
    def message
      "This triangle is not valid"
    end
  end

end
# class Triangle
#   # write code here\
#
#   def initialize(s1, s2, s3)
#
#
#
#     if s1 >= (s2 + s3) || s2 >= (s1 + s3) || s3 >= (s1 + s2)
#       raise TriangleError
#     end
#
#     if s1 <= 0 || s2 <= 0 ||s3 <= 0
#       raise TriangleError
#     end
#
#     if s1 == nil || s2 == nil ||s3 == nil
#       raise TriangleError
#     end
#
#     @s1 = s1
#     @s2 = s2
#     @s3 = s3
#   end
#
#   def kind
#     if @s1 == @s2 && @s1 == @s3
#       return :equilateral
#     elsif @s1 == @s2 || @s2 == @s3 || @s3 == @s1
#       return :isosceles
#     else
#       return :scalene
#     end
#   end
#
# end
#
#
#
# class TriangleError < StandardError
#   def message
#     "This is not a valid triangle."
#   end
# end
require 'pry'
class Triangle
  def initialize(side_1, side_2, side_3)
    @triangle_sides = []
    @triangle_sides << side_1
    @triangle_sides << side_2
    @triangle_sides << side_3
  end

  def valid?
    sum_one_two = @triangle_sides[0] + @triangle_sides[1]
    sum_one_three = @triangle_sides[0] + @triangle_sides[2]
    sum_two_three = @triangle_sides[1] + @triangle_sides[2]

    if (@triangle_sides.none? {|side| side <= 0}) &&
      (sum_one_two > @triangle_sides[2] && sum_one_three > @triangle_sides[1] && sum_two_three > @triangle_sides[0])
      return true
    else
      return false
    end
  end

  def kind
    if valid?
      if @triangle_sides.uniq.length == 1
        return :equilateral
      elsif @triangle_sides.uniq.length == 2
        return :isosceles
      else
        return :scalene
      end
    else
      raise TriangleError
    end
  end
end

class TriangleError < StandardError

end