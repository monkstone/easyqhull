import easy.EasyQhull;

double[][] data = new double[150][3];
EasyQhull hull;
double[][] vertices;

void setup() {
  size(200, 200, P3D);
  background(255);
  hull = new EasyQhull(this);      // init quickhull
  for (int i =0; i < data.length; i++){
    data[i] = getRandomPoint(random(48, 52));
  }
  hull.build(data);                 // build hull
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
}

double[] getRandomPoint(double radius){
  double z = random(-1, 1);
  double rxy = sqrt(1 - z*z);
  double phi = random(0, 2*PI);
  double x = rxy * cos(phi);
  double y = rxy * sin(phi);
  return new double[]{x * radius, y * radius, z * radius};
}
