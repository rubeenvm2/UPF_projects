import java.util.LinkedList;
import java.awt.Graphics;

public class World {
    //Atributos
    private LinkedList< Continent > conts;
    //Ctor
    public World(LinkedList< Continent > c) {
        this.conts = c;
    }
    //Metodos
    public void draw(Graphics g){
        //Dibujamos cada continente usando la funcion draw de la clase Continent
        for (int i = 0; i < conts.size(); i++){
            conts.get(i).draw(g);
        }
    }

}
