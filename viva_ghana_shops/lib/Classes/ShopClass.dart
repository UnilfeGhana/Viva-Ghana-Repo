import 'OrderClass.dart';

class ShopClass {
  String shopName;
  String pin;
  String mobile;
  Map<String, dynamic> stock;
  List<OrderClass> shop_new_orders;
  List<OrderClass> shop_pending_orders;
  List<OrderClass> shop_fulfilled_orders;
  List<OrderClass> shop_failed_orders;
  List<OrderClass> shop_history;
  String shop_db_location;

  ShopClass(
    this.shopName,
    this.pin,
    this.mobile,
    this.stock,
    this.shop_new_orders,
    this.shop_pending_orders,
    this.shop_fulfilled_orders,
    this.shop_failed_orders,
    this.shop_history,
    this.shop_db_location,
  );
}
