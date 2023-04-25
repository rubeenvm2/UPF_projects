public class TestDistanceMatrix {
    public static void main(String[] args) {
        //inicializamos la matriz y creamos 3 puntos
        DistanceMatrix matrix = new DistanceMatrix();
        GeometricPoint point1 = new GeometricPoint(4.24, 7.43, "Madrid");
        GeometricPoint point2 = new GeometricPoint(0.578, 24.5, "Barcelona");
        GeometricPoint point3 = new GeometricPoint(8.34567, 9.987, "Valencia");
        //Para verificar el funcionamiento de getNoOfCities y de addCity, miraremos el nombre de ciudades, inicialmente 0, añadiremos 3 y al final nos deberia dar 3.
        System.out.println(matrix.getNoOfCities());
        matrix.addCity(point1.getX(), point1.getY(), point1.getName());
        matrix.addCity(point2.getX(), point2.getY(), point2.getName());
        matrix.addCity(point3.getX(), point3.getY(), point3.getName());
        System.out.println(matrix.getNoOfCities()); 

        //para verificar el funcionamiento de getDistance miramos que nos de la distancia entre Barcelona y Valencia(en este caso).
        double distance = matrix.getDistance(1, 2);
        System.out.println(distance); 

    }
}
