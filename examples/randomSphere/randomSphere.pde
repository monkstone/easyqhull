import easy.EasyQhull;

float[][] data = new float[150][3];
EasyQhull hull;
float[][] vertices;

void setup() {
  size(200, 200, P3D);
  background(255);
  hull = new EasyQhull(this);      // init quickhull
  for (int i =0; i < data.length; i++){
    data[i] = getRandomPoint(random(48, 52));
  }
  hull.build(data);                 // build hull
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
}

float[] getRandomPoint(float radius){
  float z = random(-1, 1);
  float rxy = sqrt(1 - z*z);
  float phi = random(0, 2*PI);
  float x = rxy * cos(phi);
  float y = rxy * sin(phi);
  return new float[]{x * radius, y * radius, z * radius};
}