import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:viva_ghana_shops/UI/Widgets/StockCard.dart';

import '../Classes/OrderClass.dart';

class FulfilledOrderDetailsPage extends StatefulWidget {
  final OrderClass order;

  FulfilledOrderDetailsPage({super.key, required this.order});

  @override
  State<FulfilledOrderDetailsPage> createState() =>
      _FulfilledOrderDetailsPageState(this.order);
}

class _FulfilledOrderDetailsPageState extends State<FulfilledOrderDetailsPage> {
  final OrderClass order;
  _FulfilledOrderDetailsPageState(this.order);

  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List<int> relativeIndexArray = [];

  @override
  void initState() {
    super.initState();

    List<String> keyList = order.orders.keys.toList();

    for (var i = 0; i < keyList.length; i++) {
      int relativeIndex = DatabaseFunctionClass.products
          .indexWhere((product) => product.productName == keyList[i]);

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
                  buildInfoRow('Recipient Name:', order.recipientName,
                      fontSize: 18.0),
                  // Recipient Phone with Call Button
                  Row(
                    children: [
                      buildInfoRow('Recipient Phone:', order.recipientPhone,
                          fontSize: 18.0),
                      SizedBox(width: 15),
                      ElevatedButton(
                        child: Icon(Icons.call),
                        onPressed: () async {
                          final phoneNumber =
                              Uri.parse('tel:${order.recipientPhone}');

                          // Check if the device can handle the call (not in a web environment)
                          if (await canLaunchUrl(phoneNumber)) {
                            // Launch the phone app with the recipient's phone number
                            await launchUrl(phoneNumber);
                          } else {
                            // Handle if the device cannot launch the phone app
                            print('Could not launch $phoneNumber');
                          }
                        },
                      ),
                    ],
                  ),
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
                  const SizedBox(height: 20),
                  // Total
                  buildInfoRow('Total:', order.total,
                      fontSize: 24.0, color: Colors.green),
                ],
              ),
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
