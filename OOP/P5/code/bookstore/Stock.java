package bookstore;
import java.util.Currency;
public class Stock implements StockInterface {
    protected Book book;
    protected int copies;
    protected double price;
    protected Currency currency;
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
        return this.copies;
    }

    @Override
    public void addCopies(int numberOfCopies) {
        this.copies += numberOfCopies;
    }

    @Override
    public void removeCopies(int numberOfCopies) {
        this.copies -= numberOfCopies;
        
    }

    @Override
    public double totalPrice() {
        return this.copies*this.price;
    }
    
    @Override
    public double getPrice(){
        return this.price;
    }

    @Override
    public Currency getCurrency(){
        return this.currency;
    }
}
