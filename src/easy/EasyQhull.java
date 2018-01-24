/*
 * A little shim for the easy use of QuickHull3D in processing
 */
package easy;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import processing.core.PApplet;
import quickhull3d.Point3d;

/**
 *
 * @author Martin Prout
 */
public class EasyQhull extends quickhull3d.QuickHull3D {

    final String VERSION;
    final int X = 0;
    final int Y = 1;
    final int Z = 2;
    PApplet parent;

    /**
     *
     * @param parent
     */
    public EasyQhull(PApplet parent) {
        super();
        this.VERSION = "0.2";
        this.parent = parent;
        setActive(true);
    }

    /**
     *
     * @param pts
     */
    public void build(float[][] pts) {
        List<Point3d> list = new ArrayList<>();
        for (float[] pt : pts) {
            Point3d p3 = new Point3d((double) pt[0], (double) pt[1], (double) pt[2]);
            list.add(p3);
        }
        super.build(list.toArray(new Point3d[list.size()]));
    }

    /**
     *
     * @return
     */
    public float[][] getVertArray() {
        float[][] vertices = new float[numVertices][3];
        for (int i = 0; i < numVertices; i++) {
            vertices[i][X] =  (float) pointBuffer[vertexPointIndices[i]].getPoint().x;
            vertices[i][Y] =  (float) pointBuffer[vertexPointIndices[i]].getPoint().y;
            vertices[i][Z] =  (float) pointBuffer[vertexPointIndices[i]].getPoint().z;
        }
        return vertices;
    }

    /**
     * Check the Hull and print any error messages to the console
     *
     * @return
     */
    public boolean check() {
        return super.check(System.err);
    }

    /**
     * Uses built in QuckHull3D utility to export data as wavefront obj file
     *
     * @param file
     */
    public void exportWavefront(String file) {
        File obj = new File(parent.dataPath(file));
        PrintStream ps;
        try {
            obj.getParentFile().mkdirs();
            obj.createNewFile();
            ps = new PrintStream(obj);
            try {
                ps.append("# Wavefront obj file generated by QuickHull3D\n");
                super.print(ps);
            } finally {
                ps.close();
            }
        } catch (FileNotFoundException ex) {
            Logger.getLogger(EasyQhull.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(EasyQhull.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    /**
     * Tidy method for registering methods
     * @param active 
     */
    public final void setActive(boolean active) {
        if (active) {
            parent.registerMethod("dispose", this);
        } else {
            parent.unregisterMethod("dispose", this);
        }
    }

    /**
     * Required by processing
     *
     * @return
     */
    public String version() {
        return VERSION;
    }

    /**
     * Required by processing
     */
    public void dispose() {
        setActive(false);
    }
}
