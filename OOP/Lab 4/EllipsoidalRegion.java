import java.awt.*;
public class EllipsoidalRegion extends Region{
    private Point c;//Centro
    //Los dos radios de la elipsoide
    private double r1;
    private double r2;
    //Ctor
    public EllipsoidalRegion(Point c, double r1, double r2, Color linecolor, Color fillColor) {
        //Ejecutamos el ctor de la clase padre en este caso Region y le pasamos los argumentos de esta, en este caso el color de la linea
        super(linecolor, fillColor);
        //Inicializamos los 3 atributos de la clase
        this.c = c;
        this.r1 = r1;
        this.r2 = r2;
    }
    //Getter del area
    public double getArea(){
        return Math.PI*r1*r2;
    }
    @Override
    //Sobreescribimos el draw de region el cual era abstracto
    public void draw(Graphics g){
        g.setColor(fillColor);
        g.fillOval((int)c.getX(),(int) c.getY(),(int) r1,(int) r2);
        g.setColor(lineColor);
        g.drawOval((int)c.getX(), (int) c.getY(), (int) r1, (int) r2);
    }   
    @Override
    //Sobreescribimos el metodo isPointInside de Region el cual era abstracto, por lo que lo definimos ahora
    public boolean isPointInside(Point p) {
        
        double numerador1 = Math.pow(p.getX()-this.c.getX(),2);//(px-cx)^2
        double denominador1 = Math.pow(r1, 2);//a^2
        double numerador2 = Math.pow(p.getY()-this.c.getY(), 2);//(py-cy)^2
        double denominador2 = Math.pow(r2, 2);//b^2
        if((numerador1/denominador1)+(numerador2/denominador2) <= 1){//Lo juntamos todo para formar la formula, si da menor que 1, estara dentro, en cualquier otro caso, el punto estara fuera
            return true;
        }
        return false;
    }
    @Override
    //Sobreescribimos el metodo abstracto translate y lo definimos aqui llamando a translate del centro, lo cual hara que se mueva toda la elipse
    public void translate(int dx, int dy) {
        this.c.translate(dx, dy);
    }
}