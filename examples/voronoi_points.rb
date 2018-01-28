require 'easyqhull'
#java_import 'easy.Voronoi'
require 'set'

attr_reader :voronoi

def settings
  size(300, 300)
end

def setup
  sketch_title 'Voronoi'
  color_mode HSB, 1.0
  values = (0..100).map { Point.new(rand*300, rand*300) }
  @voronoi = VoronoiImp.new.from_points(values)
end

def draw
  regions = voronoi.get_regions
  regions.each do |region|
    region_coordinates = region.get_coords
    fill(rand, rand, rand)
    region.draw(self)
  end
end
