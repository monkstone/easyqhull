#frozen_string_literal: true

class Point
  include PointInterface

  attr_reader :x, :y
  def initialize(x, y)
    @x, @y = x, y
  end

  def self.random(width, height)
    new(rand * width, rand * height)
  end
end

class VoronoiImp
  include VoronoiFactory

  def from_points(values)
    points = values.map { |value| [value.x, value.y] }
     Voronoi.new(points.to_java(Java::double[]))
   end
 end
