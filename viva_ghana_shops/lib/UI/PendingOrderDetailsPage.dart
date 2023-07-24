import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/Classes/ProductClass.dart';
import 'package:viva_ghana_shops/UI/Widgets/MedicineCardWidget.dart';
import 'Widgets/OrderMedicineCardWidget.dart';

import '../Classes/OrderClass.dart';

class PendingOrderDetailsPage extends StatefulWidget {
  OrderClass order;
  PendingOrderDetailsPage({super.key, required this.order});

  @override
  State<PendingOrderDetailsPage> createState() =>
      _PendingOrderDetailsPageState(this.order);
}

class _PendingOrderDetailsPageState extends State<PendingOrderDetailsPage> {
  OrderClass order;
  _PendingOrderDetailsPageState(this.order);

  //Create DatabaseFunctionClass and edit the Cart map to contain the values you want
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List<int> relativeIndexArray = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print('Debug Order name is ${order.orders.keys}');
    //First getting the index at which the selected medicine is located in the
    //DatabaseFunctionClass's productList
    appendArray();
  }

  appendArray() {
    List keyList = order.orders.keys.toList();
    print("Debug KeyList ${keyList.length}");

    for (int i = 0; i < keyList.length; i++) {
      int relativeIndex = DatabaseFunctionClass.products
          .indexWhere((product) => product.productName == keyList[i]);

      if (relativeIndex == -1) {
        continue;
      }

      setState(() {
        relativeIndexArray.add(relativeIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            const SizedBox(height: 10),
            ////Recipient Name
            Row(
              children: [
                const Text(
                  'Recipient Name: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                Text(
                  order.recipientName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            /////////Spacer////////
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Recipient Phone: ',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SelectableText(
                  order.recipientPhone,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
            /////////Spacer////////
            const SizedBox(height: 20),
            ListView.builder(
                controller: controller,
                shrinkWrap: true,
                itemCount: relativeIndexArray.length,
                itemBuilder: (
                  BuildContext context,
                  index,
                ) {
                  return OrderMedicineCard(
                      medicineName: order.orders.keys.toList()[index],
                      order: order,
                      itemIndex: relativeIndexArray[index]);
                }),
            //For spacing
            const SizedBox(height: 20),
            // Row(
            //   children: [const Text('Total:'), Text(order.total)],
            // ),
            /////////On Fulfill Order
            ElevatedButton(
                onPressed: () {
                  print("Debug Order from Page is ${order.orders}");
                  EventHandler(context).on_fulfill_order(order);
                },
                child: const Text('Confirm Fulfill Order')),

            //For spacing
            const SizedBox(height: 10),
            /////////On Fail Order
            ElevatedButton(
                onPressed: () {
                  EventHandler(context).on_fail_order(order);
                },
                child: const Text('Fail Order'))
          ],
        ),
      ),
    );
  }
}
