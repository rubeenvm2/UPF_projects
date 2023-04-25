import java.util.LinkedList;
import java.awt.Graphics;

public class PolygonalRegion {
    //Atributos
    private LinkedList< Point > points;
    //Ctor
    public PolygonalRegion(LinkedList< Point > l) {
        this.points = l;
    }
    //Metodos
    //Calculamos el area de la region usando la formula pertinente.
    public double getArea(){
        double det1 = 0;
        double det2 = 0;
        for(int i = 0; i < points.size()-1; i++){
            det1 = det1 + (points.get(i).getX()*points.get(i+1).getY());
            det2 = det2 + (points.get(i).getY()*points.get(i+1).getX());
        }
        det1 = det1 + (points.getLast().getX()*points.getFirst().getY()) ;
        det2 = det2 + (points.getLast().getY()*points.getFirst().getX());
        double det = det1-det2;
        double area = 0.5 * det;
        return area;
    }

    public void draw(Graphics g){
        //Cada punto se unira con el siguiente creado
        for(int i = 0; i < points.size()-1; i++){
            g.drawLine( (int) points.get(i).getX(), (int)points.get(i).getY(), (int) points.get(i+1).getX(), (int) points.get(i+1).getY());
        }
        //Creamos el enlace que conecte el ultimo punto con el primero
        g.drawLine((int) points.getLast().getX(), (int) points.getLast().getY(), (int) points.getFirst().getX(), (int) points.getFirst().getY());
   
    }

}
