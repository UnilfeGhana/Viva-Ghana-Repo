import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';

import '../Classes/OrderClass.dart';
import 'Widgets/MedicineCardWidget.dart';

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

    // for (int i = 0; i < keyList.length; i++) {
    //   print('Debug Keys');

    //   int relativeIndex = DatabaseFunctionClass.products
    //       .indexWhere((product) => product.productName == keyList[i]);

    //   setState(() {
    //     relativeIndexArray.add(relativeIndex);
    //   });
    // }
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
                    itemCount: relativeIndexArray.length,
                    itemBuilder: (
                      BuildContext context,
                      index,
                    ) {
                      return CustomCard(relativeIndexArray[index], 'total');
                      // return MedicineCardWidget(
                      //     //  'Viva Plus (90)',
                      //     in_dbfc: dbfc,
                      //     itemIndex: relativeIndexArray[index]);
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
                    price,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  ///////////////////////////
                  ///       Spacer     /////
                  const SizedBox(height: 10),
                  /////////End//////////////
                  /////////////////////////////////////////
                  ///   Container for Text Input Fied   ///
                  ////////////////////////////////////////
                  Container(
                    width: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: amount,
                      ),
                      keyboardType: TextInputType.number,
                      //Change to read only if canEdit bool is false
                      onChanged: (value) {
                        if (int.tryParse(value) != null) {
                          // return;
                          //////// If the value is greater than zero edit the amount
                          ////// Then edit the Sub-Total
                          if (int.tryParse(value)! > 0) {
                            setState(() {
                              DatabaseFunctionClass.cartList[itemIndex].amount =
                                  value;
                              // _dbfc.cartMap[productName]?.amount = value;
                              total = DatabaseFunctionClass
                                  .cartList[itemIndex].subTotal;
                            });
                          }
                          ////If the value is less than 1 remove the medicine from the cart
                          ////// Then edit the Sub-Total
                          else if (int.tryParse(value)! < 1) {
                            setState(() {
                              DatabaseFunctionClass.cartList[itemIndex].amount =
                                  '0';
                              total = DatabaseFunctionClass
                                  .cartList[itemIndex].subTotal;
                            });
                          }
                        }
                        /////Here a non-valid value was entered so set amount to zero
                        /// Then edit the Sub-Total
                        else {
                          setState(() {
                            DatabaseFunctionClass.cartList[itemIndex].amount =
                                '0';
                            total = DatabaseFunctionClass
                                .cartList[itemIndex].subTotal;
                          });
                        }
                      },
                    ),
                  ),
                  ///////////////////////////
                  ///       Spacer     /////
                  const SizedBox(height: 20),
                  /////////End//////////////
                  Text(
                    total,
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
