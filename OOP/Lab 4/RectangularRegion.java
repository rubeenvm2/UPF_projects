import java.awt.Color;
import java.util.Arrays;
import java.util.LinkedList;

public class RectangularRegion extends PolygonalRegion{

    public RectangularRegion(Point p1, Point p2, Point p3, Point p4, Color linecolor, Color fillColor) {
        super(new LinkedList<Point>(Arrays.asList(p1,p2,p3,p4)), linecolor, fillColor);

        //TODO Auto-generated constructor stub
    }
    @Override
    public double getArea() {
        double base = Math.sqrt(Math.pow(points.get(0).difference(points.get(1)).getX(),2)+ Math.pow(points.get(0).difference(points.get(1)).getY(),2));//sqrt((x1-x2)^2+(y1-y2)^2)-->Un lado del rectangulo
        double altura = Math.sqrt(Math.pow(points.get(1).difference(points.get(2)).getX(),2)+ Math.pow(points.get(1).difference(points.get(2)).getY(),2));//sqrt((x2-x3)^2+(y2-y3)^2)-->Otro lado del rectangulo
        double area = base * altura;
        //Lado por lado, cualquiera.
        return area;
    }
    
}
