import java.awt.Graphics;
public abstract class Region {
    //Clase abstracta a la cual le creamos dos metodos abstractos los cuales sobreescribiremos en las clases inferiores.
    public abstract double getArea();
    public abstract void draw(Graphics g);
}
