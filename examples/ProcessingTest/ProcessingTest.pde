

import easy.EasyQhull;




EasyQhull hull;
// An array of float to store the calculated vertices of the convex hull
float[][] vertices;
// a set of initial data points
float[][] pts = {  
  { 0.0, 0.0, 0.0}
  , 
  {
    0.0, 0.0, 50.0
  }
  , 
  {
    0.0, 50.0, 0.0
  }
  , 
  {
    0.0, 50.0, 50.0
  }
  , 
  {
    50.0, 0.0, 0.0
  }
  , 
  {
    50.0, 0.0, 50.0
  }
  , 
  {
    50.0, 50.0, 50.0
  }
  , 
  {
    50.0, 50.0, 0.0
  }
};

void setup() {
  size(200, 200, P3D);
  background(255);
  hull = new EasyQhull(this);      // init quickhull
  hull.build(pts);                 // build hull
  hull.triangulate();              // triangulate faces
  vertices = hull.getVertArray();  // get vertices as an array of float[]
  if (hull.check()) {
    hull.exportWavefront("test.obj");
  }
}    

void draw() {
  background(255);
  smooth();
  translate(width / 2, height / 2);
  rotateY(frameCount * 0.01);
  rotateZ(frameCount * 0.01);        
  pushMatrix();
  translate(-25, -25, -25);
  beginShape(TRIANGLES);
  int[][] faceIndices = hull.getFaces();
  //run through faces (each point on each face), and draw them
  for (int i = 0; i < faceIndices.length; i++) {
    for (int k = 0; k < faceIndices[i].length; k++) {
      //get points that correspond to each face
      float[] pnt2 = vertices[faceIndices[i][k]];
      float x = pnt2[X];
      float y = pnt2[Y];
      float z = pnt2[Z];
      vertex(x, y, z);
    }
  }
  endShape();
  popMatrix();
}


