package quickhull3d;

import easy.EasyQhull;
import processing.core.PApplet;

/**
 *
 * @author foo
 */
public class ProcessingTest extends PApplet {

    EasyQhull hull;
// An array of double to store the calculated vertices of the convex hull
    double[][] vertices;
// a set of initial data points
    double[][] pts = {
        {0.0f, 0.0f, 0.0f},
        {0.0f, 0.0f, 50.0f},
        {0.0f, 50.0f, 0.0f},
        {0.0f, 50.0f, 50.0f},
        {50.0f, 0.0f, 0.0f},
        {50.0f, 0.0f, 50.0f},
        {50.0f, 50.0f, 50.0f},
        {50.0f, 50.0f, 0.0f}
    };

    /**
     *
     */
    @Override
    public void setup() {
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

    /**
     *
     */
    @Override
    public void draw() {
        background(255);
        smooth();
        translate(width / 2, height / 2);
        rotateY(frameCount * 0.01f);
        rotateZ(frameCount * 0.01f);
        pushMatrix();
        translate(-25, -25, -25);
        beginShape(TRIANGLES);
        int[][] faceIndices = hull.getFaces();
        //run through faces (each point on each face), and draw them
        for (int[] faceIndice : faceIndices) {
            for (int k = 0; k < faceIndice.length; k++) {
                //get points that correspond to each face
                double[] pnt2 = vertices[faceIndice[k]];
                double x = pnt2[X];
                double y = pnt2[Y];
                double z = pnt2[Z];
                vertex(x, y, z);
            }
        }
        endShape();
        popMatrix();
    }

    /**
     *
     * @param args
     */
    static public void main(String args[]) {
        PApplet.main(new String[]{"--bgcolor=#DFDFDF", "quickhull3d.ProcessingTest"});
    }
}
