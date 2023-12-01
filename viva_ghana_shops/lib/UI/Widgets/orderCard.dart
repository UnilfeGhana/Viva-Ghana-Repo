import 'package:flutter/material.dart';

import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/Classes/OrderClass.dart';

// ignore: must_be_immutable
class OrderCardWidget extends StatefulWidget {
  String index;
  bool available;
  String name;
  OrderClass order;
  OrderCardWidget(
      {super.key,
      required this.index,
      required this.available,
      required this.name,
      required this.order});

  @override
  State<OrderCardWidget> createState() =>
      _OrderCardWidgetState(index, available, name, order);
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  String name;
  String phone = '0204050873';
  String index;
  bool available;
  OrderClass order;
  _OrderCardWidgetState(this.index, this.available, this.name, this.order);
  late EventHandler eventH;
  @override
  Widget build(BuildContext context) {
    eventH = EventHandler(context);
    // TestProvider tp = Provider.of<TestProvider>(context, listen: false);
    // name = tp.value;
    // available = tp.col_val;
    return GestureDetector(
      onTap: () {
        eventH.on_open_order(order, context);
      },
      child: Container(
        height: 105,
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: (available)
              ? const Color.fromARGB(255, 189, 232, 140)
              : Color.fromARGB(255, 250, 137, 129),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Index
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Text(
                index,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            //Info
            SizedBox(
              height: 100,
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(phone),
                  ),
                ],
              ),
            ),
            // Icon
            IconButton(
              icon: Icon(Icons.arrow_forward),
              iconSize: 35,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
