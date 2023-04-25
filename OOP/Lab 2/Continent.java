import java.util.LinkedList;
import java.awt.Graphics;

public class Continent {
    //Atributos
    private LinkedList< PolygonalRegion > regions;
    //Ctor
    public Continent(LinkedList< PolygonalRegion > c) {
        this.regions = c;
    }
    //Metodos
    public double getTotalArea(){
        double total_area = 0;
        //Para cada region calculamos su area usando getArea de la clase PolygonalRegion y las vamos sumando
        for (int i = 0; i < regions.size(); i++){
            total_area += regions.get(i).getArea();
        }
        return total_area;
    }
    public void draw(Graphics g){
        //Dibujamos cada region usando el draw de la clase PolygonalRegion
        for (int i = 0; i < regions.size(); i++){
            regions.get(i).draw(g);
        }
    }
}
