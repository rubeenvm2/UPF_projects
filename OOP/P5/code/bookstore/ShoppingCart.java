package bookstore;
import java.util.Currency;

public class ShoppingCart extends BookCollection implements ShoppingCartInterface {
    private Catalog catalog;
    public ShoppingCart(Catalog catinit) {
        this.catalog = catinit;//Inicializo el catalogo de la tienda
        //Creo la coleccion que sera mi carrito añadiendo una instancia de stock por cada libro del catalogo.
        for (StockInterface books: catalog.collection){
            StockInterface books_on_cart = new Stock(books.getBook(), 0, books.getPrice(), books.getCurrency());
            collection.add(books_on_cart);
        }
    }
    @Override
    public void addCopies(int numberOfCopies, String booktitle){
        //Primero elimino las copias del catalogo de la tienda
        for(StockInterface books : catalog.collection){
            if(books.getBooktitle().equals(booktitle)){
                books.removeCopies(numberOfCopies);        
            }
        }
        //Ahora añado las copias al carrito de la compra
        for(StockInterface books : collection){
            if(books.getBooktitle().equals(booktitle)){
                books.addCopies(numberOfCopies);
            }
        }
    }
    @Override
    public void removeCopies(int numberOfCopies, String booktitle){
        //Primero sumo a la collection de la bookcollection el numero de copias que elimino del carro
        for(StockInterface books : catalog.collection){
            if(books.getBooktitle().equals(booktitle)){
                books.addCopies(numberOfCopies);        
            }
        }
        //Elimino copias de mi catalogo que es el carrito
        for(StockInterface books : collection){
            if(books.getBooktitle().equals(booktitle)){
                books.removeCopies(numberOfCopies);
            }
        }    
    }
    public double totalPrice(){
        double price = 0;
        for(StockInterface books_cart :collection){
            price += books_cart.totalPrice();
        }
        return price;
    }
    public String checkout(){
        Payment payment = new Payment();
        Currency currency = Currency.getInstance("EUR");
        return payment.doPayment(102954432, "cardHolder", totalPrice(), currency);
    }
}
