import 'package:flutter/material.dart';
import '../Classes/DatabaseFunctionClass.dart';
import '../Classes/EventHandler.dart';
import '../Classes/OrderClass.dart';
import 'Widgets/OrderTileWidget.dart';

class NewOrdersPage extends StatefulWidget {
  NewOrdersPage({super.key});

  @override
  State<NewOrdersPage> createState() => _NewOrdersPageState();
}

class _NewOrdersPageState extends State<NewOrdersPage> {
  late EventHandler eventH;
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List<OrderClass> newOrders = [];
  int n = 0;

  ////////////////////////////////
  ///     Init State Method   ////
  ////////////////////////////////
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // newOrders.clear();
  }

  //////////////////////////////////////////////////
  ///     Async Function to get New Orders       ////
  //////////////////////////////////////////////////
  getNewOrders() async {
    //Change function call to get fulfilled Orders
    var temp = await dbfc.get_new_orders();
    // print("Debug2 temp is $temp");
    setState(() {
      newOrders = temp;
    });
    // print("Debug 3");
  }

  @override
  Widget build(BuildContext context) {
    if (newOrders.isEmpty) {
      n++;
      getNewOrders();
      print("Debug Npage getting $newOrders");
    }
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          //Set the item count to the number of pending orders
          itemCount: newOrders.length,
          itemBuilder: (BuildContext context, index) {
            //return OrderTileWidget
            return OrderTileWidget(
              order: newOrders[index],
              orderNumber: index + 1,
            );
          },
        ));
  }
}
