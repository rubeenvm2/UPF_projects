import java.awt.Color;
import java.util.Arrays;
import java.util.LinkedList;

public class TriangularRegion extends PolygonalRegion {
    //Ctor
    public TriangularRegion(Point p1, Point p2, Point p3, Color linecolor, Color fillcolor) {
        //Inicializamos los argumentos del ctor de la clase padre
        super(new LinkedList<Point>(Arrays.asList(p1,p2,p3)), linecolor, fillcolor);
    }
    @Override
    public double getArea() {
        double base = Math.sqrt(Math.pow(points.get(0).difference(points.get(1)).getX(),2) + Math.pow(points.get(0).difference(points.get(1)).getY(),2));//sqrt((x1-x2)^2+(y1-y2)^2) expected: 50
        double altura1 = Math.pow(points.get(0).middlePoint(points.get(1)).difference(points.get(2)).getX(),2);//(x del punto medio(x1,x2)-x3)^2 Expected: 0
        double altura2 = Math.pow(points.get(0).middlePoint(points.get(1)).difference(points.get(2)).getY(),2);//(y del punto medio(y1,y2)-y3)^2 Expected: 50
        double altura = Math.sqrt(altura1+altura2);//Sumamos los dos valores para obtener la distancia total, la de x + la de "y" y hacemos el modulo
        return (base + altura) / 2;
        //Cualquier lado es la base
        //La distancia desde el punto medio de un lado con el punto opuesto es la altura
        //Dividir entre 2 por definicion
    }
}
