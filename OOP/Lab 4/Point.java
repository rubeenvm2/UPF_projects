public class Point {
    //Atributos
    private double x;
    private double y;
    //Ctor
    public Point(double xi, double yi) {
        this.x = xi;
        this.y = yi;
    }
    //Metodos, getters y setters en este caso
    public double getX() {
        return x;
    }
    public double getY() {
        return y;
    }
    public void setX(double x) {
        this.x = x;
    }
    public void setY(double y) {
        this.y = y;
    }
    //Metodo para mover el punto
    public void translate(double x, double y){
        this.x += x; //Sumamos el valor de x que nos pasan a la x que ya teniamos
        this.y += y; //Sumamos el valor de y que nos dan a la y que ya teniamos
    }
    //Metodo para calcular la diferencia entre dos puntos
    public Point difference(Point p){
        Point difference = new Point(this.x-p.getX(), this.y-p.getY());//P= (x1-x2, y1-y2)
        return difference;
    }
    //Metodo para calcular el producto escalar
    public double crossProduct(Point p){
        return (this.x*p.getY() - this.y*p.getX());//Devolemos x1*y2 - y1*x2
    }
    //Metodo para calcular el punto medio, creado para mas facilidad en la clase Triangular region
    public Point middlePoint(Point p){
        Point point = new Point(this.x, this.y);
        point.setX((this.x + p.getX())/2);
        point.setY((this.y + p.getY())/2);
        return point;//Devolvemos P = ((x1+x2)/2, (y1+y2)/2)
    }
}

