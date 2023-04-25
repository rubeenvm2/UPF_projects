import java.util.LinkedList;

public class MyMap extends javax.swing.JPanel {
    private World world;
    public MyMap() {
        initComponents();
        //Region 1
        LinkedList< Point > points1 = new LinkedList< Point >();//Creamos una lista de puntos
        LinkedList< Point > points2 = new LinkedList< Point >();//Creamos una lista de puntos
        //Añadimos 3 puntos a la lista de puntos1
        points1.add( new Point( 10, 100 ) );
        points1.add( new Point( 150, 10 ) );
        points1.add( new Point( 290, 100 ) );
        //Añadimos 4 puntos a la lista de puntos2
        points2.add( new Point( 290, 200 ) );
        points2.add( new Point( 150, 290 ) );
        points2.add( new Point( 25, 145 ) );
        points2.add( new Point( 10, 200 ) );
        LinkedList< PolygonalRegion > countries1 = new LinkedList< PolygonalRegion >();//Creamos la primera region
        //Añadimos las dos listas de puntos a la primera region
        countries1.add(new PolygonalRegion(points1));
        countries1.add(new PolygonalRegion(points2));


        //Region2
        LinkedList< Point > points3 = new LinkedList< Point >();//Creamos una lista de puntos
        //Añadimos 5 puntos a la lista de puntos 3
        points3.add( new Point( 160, 40 ) );
        points3.add( new Point( 50, 700 ) );
        points3.add( new Point( 59, 450 ) );
        points3.add( new Point( 460, 240 ) );
        points3.add( new Point( 360, 170 ) );
        LinkedList< PolygonalRegion > countries2 = new LinkedList< PolygonalRegion >();//Creamos la segunda region
        //Añadimos los puntos a la segunda region
        countries2.add(new PolygonalRegion(points3));


        //Region3
        LinkedList< Point > points4 = new LinkedList< Point >();//Creamos una lista de puntos
        //Añadimos 3 puntos a la lista de puntos 4
        points4.add( new Point( 400, 150 ) );
        points4.add( new Point( 600, 700 ) );
        points4.add( new Point( 20, 30 ) );
        LinkedList< PolygonalRegion > countries3 = new LinkedList< PolygonalRegion >();//Creamos la tercera region
        //Añadimos los puntos a la tercera region
        countries3.add(new PolygonalRegion(points4));

        //Continents
        LinkedList< Continent > conts = new LinkedList< Continent >();//Creamos la lista de continentes
        //Continent1
        conts.add(new Continent(countries1));//Añadimos la primera region a los continentes
        
        //Continent2
        conts.add(new Continent(countries2));//Añadimos la segunda region a los continentes

        //Continent3
        conts.add(new Continent(countries3));//Añadimos la tercera region a los continentes


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

