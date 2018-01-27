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
  reset!
end

def draw
  regions = voronoi.get_regions
  regions.each do |region|
    region_coordinates = region.get_coords
    fill(rand, rand, rand)
    region.draw(self)
  end
end

def reset!
  points = Set.new
  100.times do
    points.add([rand*300, rand*300])
  end
  @voronoi = Voronoi.new(points.to_a.to_java(Java::double[]))
end

def key_released
  reset!
end
