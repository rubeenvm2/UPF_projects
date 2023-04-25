import java.util.LinkedList;

public class MyMap extends javax.swing.JPanel {
    private World world;
    public MyMap() {
        initComponents();
        
        LinkedList< Point > points1 = new LinkedList< Point >();//Creamos una lista de puntos
        points1.add(new Point(10, 100));
        points1.add(new Point(150, 10));
        points1.add(new Point(300, 100));
        points1.add(new Point(300, 200));
        points1.add(new Point(150, 300));
        points1.add(new Point(10, 200));


        //Creamos 3 ciudades
        City bcn = new City(290, 100, 100, "BCN");
        City mad = new City(150, 150, 10, "MAD");
        City bil = new City(290, 190, 100, "BIL");
        //Creamos un pais y le añadimos las ciudades
        Country spain = new Country(points1, mad);
        spain.addCity(bcn);
        spain.addCity(mad);
        spain.addCity(bil);
        //Country spain2 = new Country(points1, bcn);
        //Country spain3 = new Country(points1, bil);

        //Creamos una lista de paises.
        LinkedList< Country > countries = new LinkedList< Country >();
        countries.add(spain);
        //countries.add(spain2);
        //countries.add(spain3);

        //Creamos una lista de continentes y creamos un continente el cual añadimos a la lista
        LinkedList< Continent > conts = new LinkedList< Continent >();
        Continent europe = new Continent(countries);
        conts.add(europe);

        //World
        world = new World(conts);//Creamos el mundo compuesto por todos los continentes
    }

    private void initComponents() {
        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 1000, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 1000, Short.MAX_VALUE)
        );
    }

    public void paint( java.awt.Graphics g ) {
        super.paint( g );
        world.draw( g );
        }

}

