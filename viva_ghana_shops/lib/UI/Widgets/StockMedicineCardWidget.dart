import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';

class StockMedicineCardWidget extends StatefulWidget {
  String medicineName;
  bool canEdit;
  DatabaseFunctionClass in_dbfc;
  int itemIndex;
  StockMedicineCardWidget(
      {super.key,
      required this.medicineName,
      required this.canEdit,
      required this.in_dbfc,
      required this.itemIndex});

  @override
  State<StockMedicineCardWidget> createState() => _StockMedicineCardWidgetState(
      this.medicineName, this.canEdit, this.in_dbfc, this.itemIndex);
}

class _StockMedicineCardWidgetState extends State<StockMedicineCardWidget> {
  String medicineName;
  bool canEdit;
  DatabaseFunctionClass _dbfc;
  int itemIndex;
  _StockMedicineCardWidgetState(
      this.medicineName, this.canEdit, this._dbfc, this.itemIndex);
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

    // amount = DatabaseFunctionClass.cartList[itemIndex].amount;
    amount = DatabaseFunctionClass.shop.stock[productName];
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
                      const SizedBox(height: 5),
                      /////////End//////////////
                      /////////////////////////////////////////
                      ///   Container for Text Input Fied   ///
                      ////////////////////////////////////////
                      Container(width: 70, child: Text('Amount is $amount')),
                      ///////////////////////////
                      ///       Spacer     /////
                      const SizedBox(height: 10),
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
            )),
      ),
    );
  }
}
