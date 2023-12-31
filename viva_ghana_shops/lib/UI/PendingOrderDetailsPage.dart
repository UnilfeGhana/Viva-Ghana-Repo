import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/Classes/ProductClass.dart';
import 'package:viva_ghana_shops/UI/Widgets/StockCard.dart';

import '../Classes/OrderClass.dart';

class PendingOrderDetailsPage extends StatefulWidget {
  final OrderClass order;

  PendingOrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  State<PendingOrderDetailsPage> createState() =>
      _PendingOrderDetailsPageState(order);
}

class _PendingOrderDetailsPageState extends State<PendingOrderDetailsPage> {
  final OrderClass order;
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();

  _PendingOrderDetailsPageState(this.order);

  @override
  void initState() {
    super.initState();
    // You can add any initialization logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipient Name
                  buildInfoRow('Recipient Name:', order.recipientName),
                  // Recipient Phone
                  buildInfoRow('Recipient Phone:', order.recipientPhone),
                  // Order Items
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      controller: controller,
                      itemCount: order.orders.length,
                      itemBuilder: (BuildContext context, index) {
                        String medicineName = order.orders.keys.toList()[index];
                        String value =
                            order.orders.values.toList()[index].toString();
                        String image = DatabaseFunctionClass.products
                            .firstWhere((element) =>
                                element.productName == medicineName)
                            .img;

                        return StockCard(
                          medicineName: medicineName,
                          value: value,
                          image: image,
                        );
                      },
                    ),
                  ),
                  // Spacing
                  const SizedBox(height: 20),
                  // Total
                  buildInfoRow('Total:', order.total,
                      fontSize: 24.0, color: Colors.green),
                ],
              ),
            ),
          ),
          // Buttons at the Bottom
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Order Member is: ${order.memberPhone}');
                    EventHandler(context).on_fulfill_order(order);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Completed'),
                ),
                ElevatedButton(
                  onPressed: () {
                    EventHandler(context).on_fail_order(order);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Fail Order'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value,
      {double fontSize = 16.0, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
          SizedBox(width: 8.0),
          Text(
            value,
            style: TextStyle(fontSize: fontSize, color: color),
          ),
        ],
      ),
    );
  }
}
