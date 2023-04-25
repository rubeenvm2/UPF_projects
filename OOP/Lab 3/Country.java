import java.util.LinkedList;
import java.awt.Graphics;

public class Country extends PolygonalRegion{
    //Atributos
    private String name;
    private LinkedList< City > cities;
    private LinkedList< Country > neighbors;
    private City capital;
    //Ctor
    public Country(LinkedList<Point> l, City capital) {
        super(l);
        this.capital = capital;
        cities = new LinkedList<City>();
        neighbors = new LinkedList<Country>();
    }
    //Metodos
    public void addCity(City c){
        this.cities.add(c);//Añadimos la ciudad que nos pasan como argumento a la lista cities
    }
    public void addNeighbor(Country c){
        neighbors.add(c);//Añadimos el country que nos pasan como argumento a la lista de vecinos
    }
    public void draw(Graphics g){
        super.draw(g);//Llamamos al draw de Polygonal region
        //Dibujamos todas las ciudades de la lista ciudades.
        for (int i = 0; i < cities.size(); i++){
            cities.get(i).draw(g);
        }
    }
    
}
