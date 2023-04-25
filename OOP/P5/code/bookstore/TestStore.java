package bookstore;
public class TestStore {
    public static void main(String[] args) {
        Catalog catalog = new Catalog();
        ShoppingCart shoppingCart = new ShoppingCart(catalog);
        BookStore bookstore = new BookStore(catalog, shoppingCart);
    }
}
