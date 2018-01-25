package quickhull3d;

import easy.EasyQhull;

import java.io.PrintStream;
import processing.core.PApplet;
import processing.core.PShape;

/**
 *
 * @author foo
 */
public class PShapeTest extends PApplet {

    EasyQhull hull = new EasyQhull(this); //init quickhull
    Point3d[] points; //init Point3d array
    PShape shape;
    PrintStream ps;

    /**
     *
     */
    @Override
    public void setup() {

        size(400, 400, P3D);
        background(255);

        //point array
        points = new Point3d[]{
            new Point3d(0.0f, -80f, 0.0f),
            new Point3d(0.0f, 0.0f, 0.0f),
            new Point3d(0.0f, 0.0f, 100.0f),
            new Point3d(0.0f, 100.0f, 0.0f),
            new Point3d(0.0f, 100.0f, 100.0f),
            new Point3d(100.0f, 0.0f, 0.0f),
            new Point3d(100.0f, 0.0f, 100.0f),
            new Point3d(100.0f, 100.0f, 100.0f),
            new Point3d(100.0f, 100.0f, 0.0f)
        };


        hull.build(points);  //build hull
        hull.triangulate();  //triangulate faces
        if (hull.check()) {
            hull.exportWavefront("test.obj");
        }
        Point3d[] vertices = hull.getVertices();  //get vertices
        shape = createShape();
        shape.beginShape(TRIANGLES);
        shape.ambient(200, 100, 100);
        shape.specular(50, 20, 20);
        int[][] faceIndices = hull.getFaces();
        //run through faces (each point on each face), and draw them
        for (int[] faceIndice : faceIndices) {
            for (int k = 0; k < faceIndice.length; k++) {
                //get points that correspond to each face
                Point3d pnt2 = vertices[faceIndice[k]];
                double x = (double) pnt2.x;
                double y = (double) pnt2.y;
                double z = (double) pnt2.z;
                shape.vertex(x, y, z);
            }
        }
        shape.endShape();
        shape.translate(-50, -50, -50);
    }

    /**
     *
     */
    @Override
    public void draw() {
        background(255);
        smooth(8);
        translate(width / 2, height / 2);
        rotateY(frameCount * 0.01f);
        rotateZ(frameCount * 0.01f);
        lights();
        ambientLight(200, 200, 200);
        lightSpecular(150, 150, 150);
        shape(shape);
    }

    /**
     *
     * @param passedArgs
     */
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[]{"quickhull3d.PShapeTest"};
        if (passedArgs != null) {
            PApplet.main(concat(appletArgs, passedArgs));
        } else {
            PApplet.main(appletArgs);
        }
    }
}
