import 'ProductClass.dart';

class CartSystem {
  static List<CartClass> cartItems = [];

  // Add item to the cart
  void addToCart(ProductClass product, int quantity) {
    // Check if the product is already in the cart
    CartClass? existingCartItem =
        cartItems.firstWhereOrNull((item) => item.product == product);

    if (existingCartItem != null) {
      // If the product is already in the cart, update the quantity
      existingCartItem.quantity += quantity;
    } else {
      // If the product is not in the cart, add a new cart item
      cartItems.add(CartClass(product, quantity));
    }
  }

  // Update quantity of an item in the cart
  void updateQuantity(ProductClass product, int newQuantity) {
    CartClass? existingCartItem =
        cartItems.firstWhereOrNull((item) => item.product == product);

    if (existingCartItem != null) {
      existingCartItem.quantity = newQuantity;
    }
  }

  // Remove item from the cart
  void removeFromCart(ProductClass product) {
    cartItems.removeWhere((item) => item.product == product);
  }

  // Clear all items from the cart
  void clearCart() {
    cartItems.clear();
  }

  //Get total price of items in the cart
  double getTotalPrice() {
    double totalPrice = 0.0;

    for (var cartItem in cartItems) {
      totalPrice += cartItem.product.price * cartItem.quantity;
    }

    return totalPrice;
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
