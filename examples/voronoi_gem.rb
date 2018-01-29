require 'easyqhull'
require 'set'

attr_reader :voronoi

def settings
  size(300, 300)
end

def setup
  sketch_title 'Voronoi'
  color_mode HSB, 1.0
  values = (0..100).map { Point.random(width, height) }
  @voronoi = Voronoi.from_points(values)
end

def draw
  regions = voronoi.regions # was get_regions
  regions.each do |region|
    region_coordinates = region.coordinates # was get_coords
    fill(rand, rand, rand)
    region.draw(self)
  end
end
