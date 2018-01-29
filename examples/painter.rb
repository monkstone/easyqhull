require 'easyqhull'

SCALE = 2.0
ISCALE = 1 / SCALE
NUM_POINTS = 2_000
attr_reader :point_array, :img, :edges

def setup
  sketch_title 'Painter'
  @img = load_image(data_path('phil.jpg'))
  @edges = load_image(data_path('phil.jpg'))
  @point_array = []
  no_loop
  (1...edges.width).each do |x|
    (0...edges.height).each do |y|
      # Pixel location and color
      loc = x + y * edges.width
      pix = edges.pixels[loc]
      # Pixel to the left location and color
      left_loc = x - 1 + y * edges.width
      left_pix = edges.pixels[left_loc]
      # New color is difference between pixel and left neighbor
      diff = (brightness(pix) - brightness(left_pix)).abs
      edges.pixels[left_loc] = color(diff)
    end
  end
  while point_array.length < NUM_POINTS
    pnt = Point.random(edges.width, edges.height)
    point_array << pnt if red(edges.get(pnt.x, pnt.y)) > 1
  end
end

def draw
  image(img, 0, 0, width, height )
  voronoi = Voronoi.from_points(point_array)
  my_regions = voronoi.regions
  my_regions.each_with_index do |region, i|
    c = img.get(point_array[i].x, point_array[i].y)
    fill(c)
    stroke(red(c)*0.9, green(c)*0.9, blue(c)*0.9)
    draw_region(region)
  end
  fill(0)
  no_fill
end

def draw_region(poly)
  begin_shape
  coords = poly.coordinates
  coords.each { |coord| vertex((coord[0] * SCALE), (coord[1] * SCALE)) }
  end_shape(CLOSE)
end

def settings
  size(1200, 932)
  smooth(8)
end
