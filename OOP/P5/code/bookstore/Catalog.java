package bookstore;
import java.text.SimpleDateFormat;
import java.util.Currency;
import java.util.Date;

public class Catalog extends BookCollection {
    public Catalog() {
        for(String[] books: BookCollection.readCatalog("books.xml")){
            Date date = new Date();
            try { date = new SimpleDateFormat().parse( books[2] );}
            catch( Exception e ) {}
            long isbn = Long.parseLong( books[4] );
            double price = Double.parseDouble( books[5] );
            Currency currency = Currency.getInstance( books[6] );
            int copies = Integer.parseInt( books[7] );
            Book book = new Book(books[0], books[1], date, books[3], isbn);
            StockInterface book2 = new Stock(book, copies, price, currency);
            collection.add(book2);//He de guardar una stock interface por cada libro, ya que la relacion es 1:1 entre book y stock.
            //Luego ir añadiendo a collection cada stock interface con los valores parseados como está hecho arriba, eso es lo unico que hará catalog, crear esa hashlist Collection.
        }
    }    
}
