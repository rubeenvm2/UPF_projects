import java.awt.Graphics;
public class City extends GeoPoint{
    private int numhab;
    public City(double xi, double yi, int h, String n) {
        super(xi, yi, n);
        this.numhab = h;
    }
    public void draw(Graphics g){
        super.draw(g);
    }
    
}
