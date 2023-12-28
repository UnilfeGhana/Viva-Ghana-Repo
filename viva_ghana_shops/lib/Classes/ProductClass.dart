class ProductClass {
  String productName;
  String price;
  String img;
  ProductClass(this.productName, this.price, this.img);
}

class CartClass {
  ProductClass product;
  String amount;
  late String subTotal;

  CartClass(this.product, this.amount) {
    subTotal = (int.parse(product.price) * int.parse(amount)).toString();
  }
}
