require 'easyqhull'

attr_reader :hull, :vertices

POINTS = [
  [0.0, 0.0, 0.0],
  [0.0, 0.0, 50.0],
  [0.0, 50.0, 0.0],
  [0.0, 50.0, 50.0],
  [50.0, 0.0, 0.0],
  [50.0, 0.0, 50.0],
  [50.0, 50.0, 50.0],
  [50.0, 50.0, 0.0]
]

def setup
  sketch_title 'Test 3D'
  background(255)
  @hull = EasyQhull.new(self) # init quickhull
  hull.build(POINTS.to_java(Java::double[])) # build hull
  hull.triangulate # triangulate faces
  @vertices = hull.getVertArray # get vertices as an array of double[]
  hull.exportWavefront(data_path('test.obj')) if hull.check
end

def draw
  background(255)
  translate(width / 2, height / 2)
  rotateY(frameCount * 0.01)
  rotateZ(frameCount * 0.01)
  pushMatrix
  translate(-25, -25, -25)
  beginShape(TRIANGLES)
  faceIndices = hull.getFaces
  #run through faces (each point on each face), and draw them

  faceIndices.each do |face|
    #get points that correspond to each face
    face.length.times do |i|
      pnt2 = vertices[face[i]]
      vertex(pnt2[X], pnt2[Y], pnt2[Z])
    end
  end
  endShape
  popMatrix
end

def settings
  size(200, 200, P3D)
end
