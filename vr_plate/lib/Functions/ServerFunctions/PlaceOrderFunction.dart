import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vr_plate/Class/Local/UserClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/LocationClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';

class ServerPlaceorder {
  FirebaseFirestore cloud = FirebaseFirestore.instance;
  Future<bool> placeOrder(OrderClass order) async {
    Map<String, dynamic> cloudCart;

    List<CartClass> cartList = order.cartItems.values.toList();

    List<Map<String, dynamic>> list = [];

    for (var item in cartList) {
      list.add({
        'Medicine Name': item.productID,
        'Number': item.amount,
        'Price': item.price,
      });
    }

    cloudCart = {
      'Recipient': order.username,
      'Phone': order.phoneNumber,
      'Total': UserFunction.total,
      'Medicines': list,
      'Member Phone': order.memberPhone,
      'Latitude': order.latitude,
      'Longitude': order.longitude,
    };

    await cloud
        .collection('Shops')
        .doc(LocationClass.closestShop)
        .collection('new_orders')
        .add(cloudCart);
    return true;
  }
}
