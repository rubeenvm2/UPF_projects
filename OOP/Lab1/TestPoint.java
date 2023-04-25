public class TestPoint {
    public static void main(String[] args) {
        //Creamos 2 puntos, en este caso con nombre de ciudades.
        GeometricPoint p1 = new GeometricPoint(1, 2, "Barcelona");
        GeometricPoint p2 = new GeometricPoint(1, 4, "Madrid");
        //Imprimimos la distancia entre estos dos puntos para verificar que la funcion distancia funcione correctamente
        System.out.println("La distancia de p1 a p2 es " + p1.distance(p2));
    }
}
