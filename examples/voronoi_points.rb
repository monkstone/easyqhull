require 'easyqhull'
#java_import 'easy.Voronoi'
require 'set'
include VoronoiFactory

attr_reader :voronoi

class Point
  include PointInterface

  attr_reader :x, :y
  def initialize(x, y)
    @x, @y = x, y
  end
end

def settings
  size(300, 300)
end

def setup
  sketch_title 'Voronoi'
  color_mode HSB, 1.0
  values = (0..100).map { Point.new(rand*300, rand*300) }
  @voronoi = from_points(values)
end

def from_points(values)
  points = values.map { |value| [value.x, value.y] }
   Voronoi.new(points.to_java(Java::double[]))
 end

def draw
  regions = voronoi.get_regions
  regions.each do |region|
    region_coordinates = region.get_coords
    fill(rand, rand, rand)
    region.draw(self)
  end
end
