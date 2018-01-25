

import easy.EasyQhull;




EasyQhull hull;
// An array of double to store the calculated vertices of the convex hull
double[][] vertices;
// a set of initial data points
double[][] pts = {  
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
  vertices = hull.getVertArray();  // get vertices as an array of double[]
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
      double[] pnt2 = vertices[faceIndices[i][k]];
      double x = pnt2[X];
      double y = pnt2[Y];
      double z = pnt2[Z];
      vertex(x, y, z);
    }
  }
  endShape();
  popMatrix();
}


