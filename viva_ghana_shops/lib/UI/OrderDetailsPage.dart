import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/Classes/ProductClass.dart';
import 'package:viva_ghana_shops/UI/Widgets/MedicineCardWidget.dart';

import '../Classes/OrderClass.dart';

class OrderDetailsPage extends StatefulWidget {
  OrderClass order;
  OrderDetailsPage({super.key, required this.order});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState(this.order);
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  OrderClass order;
  _OrderDetailsPageState(this.order);

  //Create DatabaseFunctionClass and edit the Cart map to contain the values you want
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List<int> relativeIndexArray = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //First getting the index at which the selected medicine is located in the
    //DatabaseFunctionClass's productList

    List keyList = order.orders.keys.toList();
    for (var i = 0; i < keyList.length; i++) {
      int relativeIndex = DatabaseFunctionClass.products
          .indexWhere((product) => product.productName = keyList[i]);

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
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            ////Recipient Name
            Row(
              children: [
                const Text('Recipient Name: '),
                Text(order.recipientName),
              ],
            ),
            Row(
              children: [
                const Text('Recipient Phone: '),
                Text(order.recipientPhone)
              ],
            ),
            SizedBox(
                height: 400,
                child: ListView.builder(
                    controller: controller,
                    itemCount: order.orders.keys.toList().length,
                    itemBuilder: (
                      BuildContext context,
                      index,
                    ) {
                      return MedicineCardWidget(
                          medicineName: order.orders.keys.toList()[index],
                          //  'Viva Plus (90)',
                          canEdit: false,
                          in_dbfc: dbfc,
                          itemIndex: relativeIndexArray[index]);
                    })),
            //For spacing
            const SizedBox(height: 20),
            Row(
              children: [const Text('Total:'), Text(order.total)],
            ),

            ElevatedButton(
                onPressed: () {
                  EventHandler(context).on_pend_order(order);
                },
                child: const Text('Pend Order'))
          ],
        ),
      ),
    );
  }
}
