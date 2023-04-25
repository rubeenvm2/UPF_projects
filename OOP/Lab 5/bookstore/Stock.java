package bookstore;
import java.util.Currency;
import java.util.LinkedList;

import bookstore.StockInterface;

public class Stock implements StockInterface {
    private Book book;
    private int copies;
    private double price;
    private Currency currency;
    public Stock(Book bookinit, int copinit, double priceinit, Currency curinit) {
        this.book = bookinit;
        this.copies = copinit;
        this.price = priceinit;
        this.currency = curinit;
    }
    public Book getBook() {
        return book;
    }
    @Override
    public String getBooktitle() {
        return book.getTitle();
    }

    @Override
    public int numberOfCopies() {
        for(String[] books : BookCollection.readCatalog("books.xml")){
            if(books[0] == this.book.getTitle()){
                return Integer.parseInt(books[7]);
            }
        }
        return 0;
    }

    @Override
    public void addCopies(int numberOfCopies) {
        for(String[] books : BookCollection.readCatalog("books.xml")){
            if(books[0] == this.book.getTitle()){
                for(int i = 0; i < numberOfCopies; i++){
                    
                    books[7];
                }
            }
        }
    }

    @Override
    public void removeCopies(int numberOfCopies) {
        // TODO Auto-generated method stub
        
    }

    @Override
    public double totalPrice() {
        for(String[] books : BookCollection.readCatalog("books.xml")){
            if(books[0] == this.book.getTitle()){
                return Double.parseDouble(books[5])*Integer.parseInt(books[7]);
            }
        }
        return 0;
    }
    
}
