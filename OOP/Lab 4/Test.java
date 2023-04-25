import java.awt.Color;

public class Test {
    public static void main(String[] args) {
        Point p1 = new Point(100, 100);
        Point p2 = new Point(150,100);
        Point p3 = new Point(125,150);
        Point p4 = new Point(10, 10);
        Point p5 = new Point(10,40);
        Point p6 = new Point(30,40);
        Point p7 = new Point(30,10);
        Point c = new Point(200, 200);
        Point inside_t = new Point(120, 120);
        Point inside_r = new Point(20, 20);
        double r1 = 50;
        double r2 = 50;
        Region rectangular = new RectangularRegion(p4, p5, p6, p7, Color.black, Color.blue);
        Region circular = new CircularRegion(c, r1, r2, Color.BLACK, Color.green);
        Region triangle = new TriangularRegion(p1, p2, p3, Color.black, Color.darkGray);
        System.out.println(rectangular.getArea());//600
        System.out.println(triangle.getArea());//50
        System.out.println(circular.getArea());//7853, 99
        System.out.println(triangle.isPointInside(inside_t)); // true
        System.out.println(triangle.isPointInside(p4)); //False
        System.out.println(rectangular.isPointInside(inside_r)); //true
        System.out.println(rectangular.isPointInside(p4)); //False
        System.out.println(circular.isPointInside(c)); //True
        System.out.println(circular.isPointInside(p4)); //False


        EntityDrawer e = new EntityDrawer();
        e.addDrawable(triangle);
        e.addDrawable(rectangular);
        e.addDrawable(circular);

    }
}
