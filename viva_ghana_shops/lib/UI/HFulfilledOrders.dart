import 'package:flutter/material.dart';

import '../Classes/DatabaseFunctionClass.dart';
import '../Classes/EventHandler.dart';
import '../Classes/OrderClass.dart';
import 'Widgets/OrderTileWidget.dart';

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
    setState(() {
      fulfilledOrders = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fulfilledOrders.isEmpty) {
      getFulfilled();
    }
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          //Set the item count to the number of pending orders
          itemCount: fulfilledOrders.length,
          itemBuilder: (BuildContext context, index) {
            //return OrderTileWidget
            return OrderTileWidget(
              order: fulfilledOrders[index],
              orderNumber: index,
            );
          },
        ));
  }
}
