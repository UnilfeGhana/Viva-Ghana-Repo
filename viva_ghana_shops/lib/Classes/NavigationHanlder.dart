import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/UI/HomePage.dart';
import 'package:viva_ghana_shops/UI/OrderDetailsPage.dart';
import 'package:viva_ghana_shops/UI/SellingPage.dart';
import 'package:viva_ghana_shops/main.dart';

import '../UI/AuthPage.dart';
import '../UI/PendingOrderDetailsPage.dart';
import '../UI/StockPage.dart';

class NavigationHandler {
  BuildContext context;

  NavigationHandler(this.context);

  on_change_page(String page, dynamic extra) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //Edit to link corresponding screens
      switch (page) {
        case 'HomePage':
          return const HomePage();
        case 'Auth Page':
          return const AuthPage();

        case 'Selling Page':
          return SellingPage();

        case 'Stock Page':
          return const StockPage();

        case 'Order Details Page':
          return OrderDetailsPage(order: extra);

        case 'Pending Order Details Page':
          return PendingOrderDetailsPage(order: extra);
        default:
          return const HomePage();
      }
    }));
  }

  on_clear_context() {
    Navigator.of(context).pop();
  }

  on_pop_page() {}

  on_success(String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
            content:
                const Icon(Icons.thumb_up_alt_rounded, color: Colors.green),
          );
        });
  }

  on_fail(String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('$message failed'),
            content: const Icon(Icons.not_interested, color: Colors.red),
          );
        });
  }
}
