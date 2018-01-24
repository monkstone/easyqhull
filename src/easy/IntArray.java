package easy;

public class IntArray {

    int[] data;
    int length;

    public IntArray() {
        this(1);
    }

    public IntArray(int l) {
        data = new int[l];
        length = 0;
    }

    public void add(int d) {
        int[] newArray = new int[data.length + 1];
        if (length == data.length) {
            System.arraycopy(data, 0, newArray, 0, data.length);
            data = newArray;
        }
        data[length++] = d;
    }

    public int get(int i) {
        return data[i];
    }

    public boolean contains(int d) {
        for (int i = 0; i < length; i++) {
            if (data[i] == d) {
                return true;
            }
        }
        return false;
    }
}
