import java.awt.*;
public abstract class Region extends Entity{
    //Atributos
    protected Color fillColor;
    //Ctor
    public Region(Color lcinit, Color fillColorinit) {
        //Inicializamos los atributos de la clase padre y los de esta.
        super(lcinit);
        this.fillColor = fillColorinit;
    }
    //Creamos un setter del atributo
    public void setFillColor(Color fillColor) {
        this.fillColor = fillColor;
    }
    //Creamos dos metodos abstractos por lo que la clase pasara a ser abstracta
    public abstract double getArea();
    public abstract boolean isPointInside(Point p);
}
