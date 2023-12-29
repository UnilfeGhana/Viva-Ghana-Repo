import 'package:flutter/material.dart';

import '../Classes/DatabaseFunctionClass.dart';
import '../Classes/EventHandler.dart';
import '../Classes/OrderClass.dart';
import 'Widgets/FulfilledOrderCardWidget.dart';
import 'Widgets/OrderTileWidget.dart';
import 'Widgets/orderCard.dart';

class FulfilledOrdersPage extends StatefulWidget {
  const FulfilledOrdersPage({super.key});

  @override
  State<FulfilledOrdersPage> createState() => _FulfilledOrdersPageState();
}

class _FulfilledOrdersPageState extends State<FulfilledOrdersPage> {
  late EventHandler eventH;
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List<OrderClass> fulfilledOrders = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFulfilled();
  }

  getFulfilled() async {
    var temp = await dbfc.get_fulfilled_orders();
    print(temp);
    setState(() {
      fulfilledOrders = temp;
      print(fulfilledOrders);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          //Set the item count to the number of pending orders
          itemCount: fulfilledOrders.length,
          itemBuilder: (BuildContext context, index) {
            //return OrderTileWidget
            return FulfilledOrderTileWidget(
                orderNumber: index, order: fulfilledOrders[index]);
          },
        ));
  }
}
