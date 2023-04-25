import java.awt.Graphics;
public class GeoPoint extends Point{
    private String name;
    public GeoPoint(double xi, double yi, String n) {
        super(xi, yi);
        this.name = n;
    }
    public void draw(Graphics g){
        int x = (int) this.getX();
        int y = (int) this.getY();
        g.drawString(name, x, y);
        g.fillOval( x+5, y, 10, 10);

    }
    public String getName() {
        return name;
    }
}
