import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';

import '../../Classes/OrderClass.dart';

class OrderMedicineCard extends StatefulWidget {
  String medicineName;
  OrderClass order;
  int itemIndex;
  OrderMedicineCard(
      {super.key,
      required this.medicineName,
      required this.order,
      required this.itemIndex});

  @override
  State<OrderMedicineCard> createState() =>
      _OrderMedicineCardState(this.itemIndex, this.order);
}

class _OrderMedicineCardState extends State<OrderMedicineCard> {
  int itemIndex;
  OrderClass order;
  _OrderMedicineCardState(this.itemIndex, this.order);
  String productName = '';
  String price = '';
  String img = '';
  String amount = '';
  String total = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productName = DatabaseFunctionClass.cartList[itemIndex].product.productName;
    price = DatabaseFunctionClass.cartList[itemIndex].product.price;
    img = DatabaseFunctionClass.cartList[itemIndex].product.img;

    print("Order.orders is : ${order.orders[productName]}");

    amount = '${order.orders[productName]}';
    total = DatabaseFunctionClass.cartList[itemIndex].subTotal;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
            height: 150,
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
                  decoration: BoxDecoration(
                      // color: Colors.grey,
                      image: DecorationImage(
                          image: AssetImage(img), fit: BoxFit.fitHeight)),
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
            )),
      ),
    );
  }
}
