require 'easyqhull'

attr_reader :hull, :vertices

def setup
  sketch_title 'Test 3D'
  background(255)
  @hull = EasyQhull.new(self) # init quickhull
  data = (0..150).map { get_random_point(rand(59..62.0)) }
  hull.build(data.to_java(Java::double[])) # build hull
  hull.triangulate # triangulate faces
  @vertices = hull.getVertArray # get vertices as an array of double[]
  hull.exportWavefront(data_path('test.obj')) if hull.check
end

def draw
  background(40, 40, 120)
  ambient_light(200, 190, 190)
  directional_light(55, 50, 50, 0, 1, 0)
  translate(width / 2, height / 2)
  rotate_y(frame_count * 0.01)
  rotate_z(frame_count * 0.01)
  no_stroke
  begin_shape(TRIANGLES)
  face_indices = hull.getFaces
  # run through faces (each point on each face), and draw them
  face_indices.each do |face|
    #get points that correspond to each face
    face.length.times do |i|
      pnt2 = vertices[face[i]]
      vertex(pnt2[X], pnt2[Y], pnt2[Z])
    end
  end
  end_shape
end

def get_random_point(radius)
  z = rand(-1..1.0)
  rxy = Math.sqrt(1 - z * z)
  phi = rand(0..TWO_PI)
  x = rxy * Math.cos(phi)
  y = rxy * Math.sin(phi)
  [x * radius, y * radius, z * radius]
end

def settings
  size(200, 200, P3D)
end
