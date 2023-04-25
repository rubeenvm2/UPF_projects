import java.util.LinkedList;
public class DistanceMatrix implements Matrix {
    LinkedList <GeometricPoint>cities;//Lista de GeometricPoints, en este caso ciudades
    LinkedList <LinkedList<Double>> matrix;//Lista de listas de doubles, por lo cual matriz de dobles.
    public DistanceMatrix(){
        //En el constructor inicializamos las listas sin asignarles ningun valor
        this.cities = new LinkedList<GeometricPoint>();
        this.matrix = new LinkedList<LinkedList<Double>>();
    }
    public double getDistance(int index1, int index2){
        //En esta función queremos que el usuario nos indique dos posiciones de la lista y retornarle el valor de la distancia entre estos dos puntos
        return cities.get(index1).distance(cities.get(index2));
    }
    private void AddtoArray(GeometricPoint p){
        //Añadimos el punto del cual se nos da información a la lista.
        cities.add(p);
    }
    public void createDistanceMatrix(){//El ultimo con el resto,,, esto en principio bien
        matrix.add(new LinkedList<Double>());//Nueva fila en la matriz
        //Creamos un bucle donde iteramos desde el ultimo con el resto permanentemente hasta que hayamos pre-calculado la distancia del ultimo a todos los demas puntos
        //Lo hacemos desde el ultimo porque cuando se añada una ciudad a la lista se pondrá en la ultima posición de la lista y asi se ira actualizando 
        //Finalmente añadimos el if para que el calculo con el mismo no se calcule dos veces.
        for(int i = 0; i < cities.size(); i++){
            double distance = cities.getLast().distance(cities.get(i));
            matrix.getLast().add(distance);
            if(i != cities.size()-1){
                matrix.get(i).add(distance);
            }
        }
    }
    public void addCity(double x, double y, String name){
        //Creamos un punto con la información que se nos da y lo añadimos a la lista con AddtoArray.
        GeometricPoint p = new GeometricPoint(x, y, name);
        AddtoArray(p);
    }
    //A continuación, hacemos dos getters para saber la longitud de la lista y el nombre de la ciudad que se encuentra en la posición que nos da el usuario.
    public int getNoOfCities(){
        return cities.size();
    }
    public String getCityName(int index){
        return cities.get(index).getName();
    }
}


