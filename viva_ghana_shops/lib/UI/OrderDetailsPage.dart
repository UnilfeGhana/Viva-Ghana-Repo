import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';

import '../Classes/OrderClass.dart';
import 'Widgets/MedicineCardWidget.dart';
import 'Widgets/OrderMedicineCardWidget.dart';

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
    print('Debug Order name is ${order.orders.keys}');
    //First getting the index at which the selected medicine is located in the
    //DatabaseFunctionClass's productList
    appendArray();
    print('Debug End');
  }

  appendArray() {
    List keyList = order.orders.keys.toList();
    print("Debug KeyList ${keyList.length}");

    for (int i = 0; i < keyList.length; i++) {
      print('debug');

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
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            /////////Spacer////////
            const SizedBox(height: 20),
            ////Recipient Name
            Row(
              children: [
                Text(
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
                    fontSize: 15,
                  ),
                ),
                Text(
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
            SizedBox(
                height: 400,
                child: ListView.builder(
                    controller: controller,
                    itemCount: relativeIndexArray.length,
                    itemBuilder: (
                      BuildContext context,
                      index,
                    ) {
                      return OrderMedicineCard(
                          medicineName: order.orders.keys.toList()[index],
                          order: order,
                          itemIndex: index);
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

  Widget CustomCard(int itemIndex, String total) {
    String productName =
        DatabaseFunctionClass.cartList[itemIndex].product.productName;
    String price = DatabaseFunctionClass.cartList[itemIndex].product.price;
    // img = DatabaseFunctionClass.cartList[itemIndex].product.img;

    String amount = DatabaseFunctionClass.cartList[itemIndex].amount;
    total = DatabaseFunctionClass.cartList[itemIndex].subTotal;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Container(
        height: 200,
        width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /////////////////////////////////
            ///     Container For Image  ////
            /////////////////////////////////
            Container(
              height: 250,
              width: 120,
              color: Colors.grey,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage(img), fit: BoxFit.cover)),
            ),
            ///////////////////////////////////////////////////////////
            ///   Main Container for Product Price and Name Details ///
            ///////////////////////////////////////////////////////////
            Container(
              height: 250,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///////////////////////////////////////////
                  ///   Section for Product Name and Price //
                  ///////////////////////////////////////////
                  Text(
                    productName,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  ///////////////////////////
                  ///       Spacer     /////
                  const SizedBox(height: 15),
                  /////////End//////////////
                  Text(
                    'Price: $price',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  ///////////////////////////
                  ///       Spacer     /////
                  const SizedBox(height: 0),
                  /////////End//////////////

                  ///////////////////////////
                  ///       Spacer     /////
                  const SizedBox(height: 10),
                  /////////End//////////////
                  Text(
                    'Quantity: $amount',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
