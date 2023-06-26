import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';

import '../../Classes/OrderClass.dart';

class OrderTileWidget extends StatefulWidget {
  OrderClass order;
  int orderNumber;
  OrderTileWidget({super.key, required this.order, required this.orderNumber});

  @override
  State<OrderTileWidget> createState() =>
      _OrderTileWidgetState(this.order, this.orderNumber);
}

class _OrderTileWidgetState extends State<OrderTileWidget> {
  OrderClass order;
  int orderNumber;
  _OrderTileWidgetState(this.order, this.orderNumber);
  late EventHandler eventH;
  @override
  Widget build(BuildContext context) {
    eventH = EventHandler(context);
    return GestureDetector(
        onTap: () {
          eventH.on_open_order(order, context);
        },
        //Edit Design of OrderTile Widget
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(children: [
            //SizedBox for Order Number
            SizedBox(
                width: 50,
                child: CircleAvatar(child: Text(orderNumber.toString()))),
            //Second SizedBox for Summary of Order
            SizedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                    children: [
                      const Text('Recipient Name:'),
                      Text(order.recipientName)
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Recipient Phone:'),
                      Text(order.recipientPhone)
                    ],
                  ),
                  Row(
                    children: [const Text('Total:'), Text(order.total)],
                  ),
                ]))
          ]),
        ));
  }
}
