package quickhull3d;

/**
 * Represents vertices of the hull, as well as the points from which it is
 * formed.
 *
 * @author John E. Lloyd, Fall 2004
 */
public class Vertex {

    /**
     * Spatial point associated with this vertex.
     */
    protected Point3d pnt;
    /**
     * Back index into an array.
     */
    protected int index;
    /**
     * List forward link.
     */
    protected Vertex prev;
    /**
     * List backward link.
     */
    protected Vertex next;
    /**
     * Current face that this vertex is outside of.
     */
    protected Face face;

    /**
     * Constructs a vertex and sets its coordinates to 0.
     */
    public Vertex() {
        pnt = new Point3d();
    }
    
    /**
     *
     * @return
     */
    public Point3d getPoint(){
        return pnt;
    }

    /**
     * Constructs a vertex with the specified coordinates and index.
     * @param x 
     * @param y
     * @param z 
     * @param idx  
     */
    public Vertex(double x, double y, double z, int idx) {
        pnt = new Point3d(x, y, z);
        index = idx;
    }
}
