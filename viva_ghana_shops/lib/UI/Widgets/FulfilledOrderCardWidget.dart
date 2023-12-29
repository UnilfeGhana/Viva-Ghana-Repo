import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/UI/FulfilledOrderDetailsPage.dart';

import '../../Classes/OrderClass.dart';

// ignore: must_be_immutable
class FulfilledOrderTileWidget extends StatefulWidget {
  OrderClass order;
  int orderNumber;
  FulfilledOrderTileWidget(
      {super.key, required this.order, required this.orderNumber});

  @override
  State<FulfilledOrderTileWidget> createState() =>
      _FulfilledOrderTileWidgetState(this.order, this.orderNumber);
}

class _FulfilledOrderTileWidgetState extends State<FulfilledOrderTileWidget> {
  OrderClass order;
  int orderNumber;
  _FulfilledOrderTileWidgetState(this.order, this.orderNumber);
  late EventHandler eventH;
  @override
  Widget build(BuildContext context) {
    eventH = EventHandler(context);
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return FulfilledOrderDetailsPage(order: order);
          }));
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
