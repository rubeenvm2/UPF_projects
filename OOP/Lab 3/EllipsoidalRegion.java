import java.awt.Graphics;
public class EllipsoidalRegion extends Region{
    //Atributos
    private Point c;//Centro
    private double r1;
    private double r2;
    //Ctor
    public EllipsoidalRegion(Point c, double r1, double r2) {
        this.c = c;
        this.r1 = r1;
        this.r2 = r2;
    }
    //Metodos
    public double getArea(){
        //Calculamos el area de la region
        return Math.PI*r1*r2;
    }
    @Override
    public void draw(Graphics g){
        //Sobreescribimos la función draw y dibujamos un circulo para representar la región
        g.fillOval((int)c.getX(),(int) c.getY(),(int) r1,(int) r2);
    }
}
