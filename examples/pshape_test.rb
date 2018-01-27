require 'easyqhull'

attr_reader :hull, :my_shape, :ps

POINTS = [
    [0.0, -80.0, 0.0],
    [0.0, 0.0, 0.0],
    [0.0, 0.0, 100.0],
    [0.0, 100.0, 0.0],
    [0.0, 100.0, 100.0],
    [100.0, 0.0, 0.0],
    [100.0, 0.0, 100.0],
    [100.0, 100.0, 100.0],
    [100.0, 100.0, 0.0]
]


def setup
  sketch_title 'Test PShape 3D'
  background(255)
  @hull = EasyQhull.new(self) # init quickhull
  hull.build(POINTS.to_java(Java::double[])) # build hull
  hull.triangulate # triangulate faces
  hull.exportWavefront(data_path('test.obj')) if hull.check
  vertices = hull.getVertArray # get vertices
  @my_shape = createShape
  my_shape.beginShape(TRIANGLES)
  my_shape.ambient(200, 100, 100)
  my_shape.specular(50, 20, 20)
  faceIndices = hull.getFaces
  # run through faces (each point on each face), and draw them
  faceIndices.each do |face|
    #get points that correspond to each face
    face.length.times do |i|
      pnt2 = vertices[face[i]]
      my_shape.vertex(pnt2[X], pnt2[Y], pnt2[Z])
    end
  end
  my_shape.endShape
  my_shape.translate(-50, -50, -50)
end

def draw
  background(200)
  translate(width / 2, height / 2)
  rotateY(frameCount * 0.01)
  rotateZ(frameCount * 0.01)
  lights
  ambientLight(200, 200, 200)
  lightSpecular(150, 150, 150)
  shape(my_shape)
end

def settings
  size(400, 400, P3D)
  smooth(8)
end
