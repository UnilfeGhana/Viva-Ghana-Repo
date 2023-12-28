import 'package:flutter/material.dart';

import '../Classes/DatabaseFunctionClass.dart';
import '../Classes/EventHandler.dart';
import '../Classes/OrderClass.dart';
import 'Widgets/OrderTileWidget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late EventHandler eventH;
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List<OrderClass> historyOrders = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistory();
  }

  getHistory() async {
    var temp = await dbfc.get_history();

    setState(() {
      historyOrders = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreen,
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          //Set the item count to the number of pending orders
          itemCount: historyOrders.length,
          itemBuilder: (BuildContext context, index) {
            //return OrderTileWidget
            return OrderTileWidget(
              order: historyOrders[index],
              orderNumber: index,
            );
          },
        ));
  }
}
