package quickhull3d;

/**
 * Exception thrown when QuickHull3D encounters an internal error.
 */
public class InternalErrorException extends RuntimeException {

    /**
     *
     * @param msg
     */
    public InternalErrorException(String msg) {
        super(msg);
    }
}
