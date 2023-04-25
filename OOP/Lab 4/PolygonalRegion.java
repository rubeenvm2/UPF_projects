import java.util.LinkedList;
import java.awt.*;

public class PolygonalRegion extends Region{
    //Atributos
    protected LinkedList< Point > points;
    //Ctor
    public PolygonalRegion(LinkedList< Point > l, Color linecolor, Color fillColor) {
        super(linecolor, fillColor);
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
    @Override
    //Sobreescribimos el metodo abstracto en la clase padre, definiendolo aqui
    public void draw(Graphics g){
        int pointsx [] = new int[points.size()];//Pasamos la linked list a array para poder definir luego drawPolygon y fillPolygon
        int pointsy [] = new int[points.size()];
        //Cada punto se unira con el siguiente creado
        for(int i = 0; i < points.size(); i++){
            pointsx[i] = ((int)points.get(i).getX());
            pointsy[i] = ((int)points.get(i).getY());
      }
      g.setColor(lineColor);
      g.drawPolygon( pointsx, pointsy, points.size());   
      g.setColor(fillColor);
      g.fillPolygon(pointsx, pointsy, points.size());


    }
    @Override
    //Sobreescribimos el metodo isPointInside definiendolo aqui
    public boolean isPointInside(Point p) {
        int counter_neg = 0;
        int counter_pos = 0;
        //Miramos si el signo de (q2-q1) x (p-q1) es el mismo para todos los puntos, en ese caso devolveremos true, en cualquier otro false
        for(int i = 0; i < points.size()-1; i++){
            if((points.get(i+1).difference(points.get(i))).crossProduct(p.difference(points.get(i))) < 0){
                counter_neg++;
            }
            if((points.get(i+1).difference(points.get(i))).crossProduct(p.difference(points.get(i))) > 0){
                counter_pos++;               
            } 
        }
        if(points.getFirst().difference(points.getLast()).crossProduct(p.difference(points.getLast()))< 0){
            counter_neg++;
        }
        if(points.getFirst().difference(points.getLast()).crossProduct(p.difference(points.getLast()))> 0){
            counter_pos++;
        }
        if(counter_neg == points.size() || counter_pos == points.size()){
            return true;
        }
        return false;
        
    }
    @Override
    //sobreescribimos translate haciendo que se trasladen todos los puntos de la region usando el metodo translate de Point.
    public void translate(int dx, int dy) {
        for (int i = 0; i < points.size(); i++){
            points.get(i).translate(dx, dy);;
        }        
    }


}
