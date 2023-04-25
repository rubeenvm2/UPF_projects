package bookstore;
public class ShoppingCart extends BookCollection {
    private Catalog catalog;
    public ShoppingCart(Catalog catinit) {
        this.catalog = catinit;
    }
    @Override
    public void addCopies(int numberOfCopies, String booktitle){
        if (booktitle)
    }
    @Override
    public void removeCopies(int numberOfCopies, String booktitle){

    }
    public double totalPrice(){
        return 0;
    }
    public String checkout(){
        return "0";
    }
}
