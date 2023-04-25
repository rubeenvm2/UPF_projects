import java.util.LinkedList;

public class TestArea {
    public static void main(String[] args) {
        Point p1 = new Point(2, 5);
        Point p2 = new Point(-4, 3);
        Point p3 = new Point(5, 1);
        LinkedList< Point > points = new LinkedList<Point>();
        points.add(p1);
        points.add(p2);
        points.add(p3);

        PolygonalRegion pr1 = new PolygonalRegion(points);
        System.out.println(pr1.getArea());

    }

}
