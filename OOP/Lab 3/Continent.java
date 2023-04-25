import java.util.LinkedList;
import java.awt.Graphics;

public class Continent {
    //Atributos
    private LinkedList< Country > countries;
    //Ctor
    public Continent(LinkedList< Country > c) {
        this.countries = c;
    }
    //Metodos
    public double getTotalArea(){
        double total_area = 0;
        //Para cada region calculamos su area usando getArea de la clase PolygonalRegion y las vamos sumando
        for (int i = 0; i < countries.size(); i++){
            total_area += countries.get(i).getArea();
        }
        return total_area;
    }
    public void draw(Graphics g){
        //Dibujamos cada region usando el draw de la clase PolygonalRegion
        for (int i = 0; i < countries.size(); i++){
            countries.get(i).draw(g);
        }
    }
}
