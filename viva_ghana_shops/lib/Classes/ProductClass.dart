class ProductClass {
  String productName;
  double price;
  String img;
  ProductClass(this.productName, this.price, this.img);
}

class CartClass {
  ProductClass product;
  int quantity;
  late String subTotal;

  CartClass(this.product, this.quantity) {
    subTotal = (product.price * quantity).toString();
  }
}
