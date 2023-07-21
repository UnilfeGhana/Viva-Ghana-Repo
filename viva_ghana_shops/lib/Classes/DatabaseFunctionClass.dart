import 'package:viva_ghana_shops/Classes/ServerFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/ShopClass.dart';

import 'OrderClass.dart';
import 'ProductClass.dart';

class DatabaseFunctionClass {
  static ShopClass shop = ShopClass(
      'None', 'none', 'mobile', {}, [], [], [], [], [], 'shop_db_location');

////////////////////////////////////////////////
  ///       List of Products                 ////
////////////////////////////////////////////////
  static final List<ProductClass> products = [
    ProductClass('Viva Plus (90)', '70', 'images/Viva90.jpg'),
    ProductClass('Viva Plus (120)', '90', 'images/Viva120.jpg'),
    ProductClass('Viva Lady', '100', 'images/VivaLady.jpg')
  ];

  static final List<CartClass> cartList = [
    CartClass(products[0], '0'),
    CartClass(products[1], '0'),
    CartClass(products[2], '0'),
  ];

  // Map<String, CartClass> cartMap = {};

  static ServerFunctionClass serverFunction = ServerFunctionClass();

  on_login(String shopName, String pin) async {
    ShopClass _shop = await serverFunction.get_shop(shopName, pin);
    shop = _shop;
  }

  on_logout() {
    shop = ShopClass('shopName', 'pin', 'mobile', {}, [], [], [], [], [],
        'shop_db_location');
  }

  Future<List<OrderClass>> get_new_orders() async {
    shop.shop_pending_orders =
        (await serverFunction.get_shop_new_orders(shop.shopName, shop.pin))!;
    List<OrderClass> newOrders =
        (await serverFunction.get_shop_new_orders(shop.shopName, shop.pin))!;
    var ans = serverFunction.get_shop_new_orders(shop.shopName, shop.pin);
    return newOrders;
  }

  Future<List<OrderClass>> get_pending_orders() async {
    shop.shop_pending_orders = (await serverFunction.get_shop_pending_orders(
        shop.shopName, shop.pin))!;
    List<OrderClass> pendingOrders = (await serverFunction
        .get_shop_pending_orders(shop.shopName, shop.pin))!;
    return pendingOrders;
  }

  Future<List<OrderClass>> get_fulfilled_orders() async {
    shop.shop_fulfilled_orders = (await serverFunction
        .get_shop_fulfilled_orders(shop.shopName, shop.pin))!;
    return shop.shop_fulfilled_orders;
  }

  Future<List<OrderClass>> get_failed_orders() async {
    shop.shop_failed_orders =
        (await serverFunction.get_shop_failed_orders(shop.shopName, shop.pin))!;
    return shop.shop_failed_orders;
  }

  Future<List<OrderClass>> get_history() async {
    shop.shop_history =
        (await serverFunction.get_shop_history(shop.shopName, shop.pin))!;
    return shop.shop_history;
  }

  get_stock() async {
    DatabaseFunctionClass.shop.stock =
        await serverFunction.get_shop_stock(shop.shopName, shop.pin);
    var checker = DatabaseFunctionClass.shop.stock;
    print('Debug Stock is ${checker}');
    return shop.stock;
  }

  pend_order(OrderClass order) async {
    serverFunction.on_pend_order(order, shop.shopName, shop.pin);
    shop.shop_new_orders.remove(order);
  }

  fulfill_pending_order(OrderClass order) async {
    serverFunction.on_fulfill_order(order, shop.shopName, shop.pin);
    shop.shop_pending_orders.remove(order);
  }

  fail_order(OrderClass order) async {
    serverFunction.on_fail_order(order, shop.shopName, shop.pin);
    shop.shop_pending_orders.remove(order);
  }

  reduce_stock(OrderClass order) {
    //This method first takes an order as argument
    //Next it reduces the current Stock of the shop by subtracting the input stock from the current stock
    //It then sends the result to the ServerFunction Class by calling update_shop_stock

    //The process steps through each of the keys in the order and
    //updates the shops stock to the difference between them
    print("reducing Stock for keys ${order.orders.keys}");
    var old_stock = shop.stock;
    for (var key in order.orders.keys) {
      print("Difference is ${int.parse(shop.stock[key])}");

      int ordered_amt = int.parse(order.orders[key]);
      int stocked_amt = int.parse(shop.stock[key]);

      int difference = stocked_amt - ordered_amt;

      shop.stock.update(key, (value) => difference.toString());
    }
    var new_stock = shop.stock;
    //Sending the New Stock to the Server
    print("New stock is $new_stock");
    serverFunction.update_shop_stock(new_stock, shop.shopName, shop.pin);
    //Below line is used to reset the stock of the shop in case of an error
    // serverFunction.update_shop_stock(old_stock, shop.shopName, shop.pin);
  }

  increase_stock(OrderClass order) {
    //////  INVERSE OF REDUCE STOCK////////////

    for (var key in order.orders.keys) {
      int ordered_amt = order.orders[key];
      int stocked_amt = int.parse(shop.stock[key]);
      int difference = stocked_amt + ordered_amt;
      shop.stock.update(key, (value) => difference.toString());
    }

    var new_stock = shop.stock;
    //Sending the New Stock to the Server
    serverFunction.update_shop_stock(new_stock, shop.shopName, shop.pin);
  }

  bool can_fulfill_order(OrderClass order) {
    get_stock();

    for (var key in order.orders.keys) {
      String val = order.orders[key].toString();
      try {
        int stock_amt = int.parse(DatabaseFunctionClass.shop.stock[key]);
        print("Stock amount is $stock_amt and value is: ${order.orders[key]}");
        int value = int.tryParse(val) ?? 0;
        print("Debug Value is $value");
        if (stock_amt < value) {
          return false;
        }
      } catch (e) {
        print('error caught: $e');
        return false;
      }
    }
    print("Valid Stock");
    return true;
  }
}
