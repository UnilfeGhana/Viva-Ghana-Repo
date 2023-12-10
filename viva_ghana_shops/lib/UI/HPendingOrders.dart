import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';

import '../Classes/OrderClass.dart';
import 'Widgets/OrderTileWidget.dart';
import 'Widgets/PendingOrderTileWidget.dart';
import 'Widgets/orderCard.dart';

class PendingOrdersPage extends StatefulWidget {
  const PendingOrdersPage({super.key});

  @override
  State<PendingOrdersPage> createState() => _PendingOrdersPageState();
}

class _PendingOrdersPageState extends State<PendingOrdersPage> {
  late EventHandler eventH;
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List<OrderClass> pendingOrders = [];

  @override
  //Init State
  void initState() {
    eventH = EventHandler(context);
    // TODO: implement initState
    super.initState();
    //Callingthe get pending orders event
    // eventH.on_get_pending_orders();

    get_orders();
  }

  get_orders() async {
    var temp = await dbfc.get_pending_orders();
    setState(() {
      pendingOrders = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          //Set the item count to the number of pending orders
          itemCount: pendingOrders.length,
          itemBuilder: (BuildContext context, index) {
            //return OrderTileWidget
            return OrderCardWidget(
                index: '${index + 1}',
                available: true,
                name: pendingOrders[index].recipientName,
                order: pendingOrders[index]);

            PendingOrderTileWidget(
              order: pendingOrders[index],
              orderNumber: index,
            );
          },
        ));
  }
}
