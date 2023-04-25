public class GeometricPoint {
    //Declaramos los atributs, en este caso las cordenadas x e y y el nombre de cada punto, un atributo siempre ha de ser privado.
    private double x;
    private double y;
    private String name;
    public GeometricPoint(double x, double y, String name){
        //Creamos el constructor de la clase donde asignamos cada valor introducido por el usuario a cada atributo.
        this.x = x;
        this.y = y;
        this.name = name;
    }
    //Implementamos los Setters necesarios para poder modificar el valor de las coordenadas a posteriori.
    public void setX(double x) {
        this.x = x;
    }
    public void setY(double y) {
        this.y = y;
    }
    //Implementamos los Getters para poder obtener el valor del atributo en cuestion a posteriori.
    public double getX() {
        return x;
    }
    public double getY() {
        return y;
    }
    public String getName() {
        return name;
    }
    //Aplicamos la formula de distancia en una función llamada distance.
    public double distance(GeometricPoint p){
        //Formula de la distancia
        double cateto_1 = Math.pow(p.x-x, 2);
        double cateto_2 = Math.pow(p.y-y, 2);
        double resultado = Math.sqrt(cateto_1+cateto_2);
        return resultado;
    }
}
