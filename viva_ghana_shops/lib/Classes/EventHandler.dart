import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';

import 'NavigationHanlder.dart';
import 'OrderClass.dart';

class EventHandler {
  DatabaseFunctionClass dbfClass = DatabaseFunctionClass();

  BuildContext context;
  EventHandler(this.context);

  Future<List<DocumentSnapshot>> getDocuments(
      String collectionName, shopName, pin, orderType) async {
    try {
      CollectionReference collection = FirebaseFirestore.instance
          .collection(collectionName)
          .doc('${shopName}:${pin}')
          .collection(orderType);

      QuerySnapshot querySnapshot = await collection.get();

      return querySnapshot.docs;
    } catch (e) {
      print("Error getting documents: $e");
      return [];
    }
  }

  on_login(String shopName, String pin) async {
    await dbfClass.on_login(shopName, pin);

    // FirebaseFirestore cloud = FirebaseFirestore.instance;
    // String shopsLocation = 'Shops';

    // var values =
    //     await getDocuments('Shops', 'Head Office', '0003', 'new_orders');
    // List val = [];
    // for (var element in values) {
    //   val.add(element.data());
    // }
    // print(val[0]['Total']);
    // print(val[1]['Total']);
    // await on_get_new_orders();
    // on_get_pending_orders();
    // on_get_fulfilled_orders();
    // on_get_stock();
    // on_get_history();
    NavigationHandler(context).on_change_page('HomePage', Null);
  }

  on_logout(BuildContext context) {
    dbfClass.on_logout();
    NavigationHandler(context).on_change_page('Auth Page', Null);
  }

  on_open_order(OrderClass order, BuildContext context) {
    NavigationHandler(context).on_change_page('Order Details Page', order);
  }

  on_open_pending_order(OrderClass order, BuildContext context) {
    NavigationHandler(context)
        .on_change_page('Pending Order Details Page', order);
  }

  on_pend_order(OrderClass order) async {
    NavigationHandler navHandler = NavigationHandler(context);

    if (dbfClass.can_fulfill_order(order)) {
      dbfClass.reduce_stock(order);
      dbfClass.pend_order(order);
      NavigationHandler(context).on_clear_context();
      NavigationHandler(context).on_change_page('HomePage', Null);
    } else {
      //Else show message that Shop stock is not enough
      // NavigationHandler(context).on_change_page('HomePage', Null);
      NavigationHandler(context).on_clear_context();
      navHandler.on_fail('You do not have enough stock to fulfill this Order');
    }
  }

  on_fulfill_order(OrderClass order) async {
    NavigationHandler navHandler = NavigationHandler(context);
    //If the order can be fulfilled, then fulfill it then reduce stock
    if (true) {
      //after reducing stock, get the member from the order to be commissioned
      dbfClass.fulfill_pending_order(order);
      NavigationHandler(context).on_clear_context();
      NavigationHandler(context).on_change_page('HomePage', Null);
      // await ServerFunctionClass().on_commission(order);
    }
  }

  on_fail_order(OrderClass order) {
    //Remove the Order from Pending Orders to Failed Orders
    dbfClass.fail_order(order);

    //Restock the Shop with amount
    dbfClass.increase_stock(order);
  }

  on_show_stock() {
    //Change Page to the Create Order Page
    NavigationHandler navHandler = NavigationHandler(context);
    navHandler.on_change_page('Stock Page', Null);
  }

  on_get_stock() {
    dbfClass.get_stock();
  }

  on_get_new_orders() async {
    await dbfClass.get_new_orders();
  }

  on_get_pending_orders() {
    dbfClass.get_pending_orders();
  }

  on_get_fulfilled_orders() {
    dbfClass.get_fulfilled_orders();
  }

  on_get_history() {
    dbfClass.get_history();
  }
}
