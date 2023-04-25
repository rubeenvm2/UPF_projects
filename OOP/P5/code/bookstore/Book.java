package bookstore;
import java.util.Date;

public class Book {
    private String title;
    private String author;
    private Date publicationDate;
    private String publicationPlace;
    private long ISBN;
    public Book(String tlinit, String auinit, Date dtinit, String plinit, long isbn) {
        this.title = tlinit;
        this.author = auinit;
        this.publicationDate = dtinit;
        this.publicationPlace = plinit;
        this.ISBN = isbn;
    }
    public String getTitle() {
        return title;
    }
    public String getAuthor() {
        return author;
    }
    public Date getPublicationDate() {
        return publicationDate;
    }
    public String getPublicationPlace() {
        return publicationPlace;
    }
    public long getISBN() {
        return ISBN;
    }
}