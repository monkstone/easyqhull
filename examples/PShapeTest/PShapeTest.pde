import easy.*;

import java.io.PrintStream;

EasyQhull hull = new EasyQhull(this); //init quickhull
double[][] points = {
    {0.0, -80.0, 0.0}, 
    {0.0, 0.0, 0.0}, 
    {0.0, 0.0, 100.0}, 
    {0.0, 100.0, 0.0}, 
    {0.0, 100.0, 100.0}, 
    {100.0, 0.0, 0.0}, 
    {100.0, 0.0, 100.0}, 
    {100.0, 100.0, 100.0}, 
    {100.0, 100.0, 0.0}
    };
PShape shape;
PrintStream ps;

void setup() {
  size(400, 400, P3D);
  background(255);
  smooth(8);
  background(255);
  hull.build(points);  //build hull
  hull.triangulate();  //triangulate faces
  if (hull.check()) {
    hull.exportWavefront("test.obj");
  }
  double[][] vertices = hull.getVertArray();  //get vertices
  shape = createShape();
  shape.beginShape(TRIANGLES);
  shape.ambient(200, 100, 100);
  shape.specular(50, 20, 20);
  int[][] faceIndices = hull.getFaces();
  //run through faces (each point on each face), and draw them
  for (int i = 0; i < faceIndices.length; i++) {
    for (int k = 0; k < faceIndices[i].length; k++) {
      //get points that correspond to each face
      double[] pnt2 = vertices[faceIndices[i][k]];
      float x = (float)pnt2[X];
      float y = (float)pnt2[Y];
      float z = (float)pnt2[Z];
      shape.vertex(x, y, z);
    }
  }
  shape.endShape();
  shape.translate(-50, -50, -50);
}

void draw() {
  background(200);
  translate(width / 2, height / 2);
  rotateY(frameCount * 0.01);
  rotateZ(frameCount * 0.01);
  lights();
  ambientLight(200, 200, 200);
  lightSpecular(150, 150, 150);
  shape(shape);
}