import 'package:flutter/material.dart';

import '../Classes/DatabaseFunctionClass.dart';
import '../Classes/EventHandler.dart';
import '../Classes/OrderClass.dart';
import 'Widgets/OrderTileWidget.dart';

class FailedOrdersPage extends StatefulWidget {
  const FailedOrdersPage({super.key});

  @override
  State<FailedOrdersPage> createState() => _FailedOrdersPageState();
}

class _FailedOrdersPageState extends State<FailedOrdersPage> {
  late EventHandler eventH;
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List<OrderClass> failedOrders = [];

  /////////////////////////////////
  ///     Init State Method   ////
  ////////////////////////////////
  initState() {
    super.initState();
    //Call function to get Failed Orders
    getFailedOrders();
  }

  //////////////////////////////////////////////////
  ///     Async Function to get Failed Orders   ////
  //////////////////////////////////////////////////
  getFailedOrders() async {
    //Change function call to get Failed Orders
    var temp = await dbfc.get_fulfilled_orders();
    failedOrders = temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              //Set the item count to the number of failed orders
              itemCount: failedOrders.length,
              itemBuilder: (BuildContext context, index) {
                //return OrderTileWidget
                return OrderTileWidget(
                  order: failedOrders[index],
                  orderNumber: index,
                );
              },
            )));
  }
}
