
import java.awt.*;

abstract public class Entity {
	//Atributos
	protected Color lineColor;
	//Ctor
	public Entity( Color lcinit ) {
		lineColor = lcinit;
	}
	//Getter y setter de linecolor
	public Color getLineColor() {
		return lineColor;
	}
	public void setLineColor(Color lineColor) {
		this.lineColor = lineColor;
	}
	//Metodos, abstractos en este caso, por lo que haran que la clase tambien lo sea.
	abstract public void draw( java.awt.Graphics g );

	abstract public void translate( int dx, int dy );
	
}
