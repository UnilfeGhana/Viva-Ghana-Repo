import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';

class MedicineCardWidget extends StatefulWidget {
  DatabaseFunctionClass in_dbfc;
  int itemIndex;
  MedicineCardWidget(
      {super.key, required this.in_dbfc, required this.itemIndex});

  @override
  State<MedicineCardWidget> createState() =>
      _MedicineCardWidgetState(this.in_dbfc, this.itemIndex);
}

class _MedicineCardWidgetState extends State<MedicineCardWidget> {
  DatabaseFunctionClass _dbfc;
  int itemIndex;
  _MedicineCardWidgetState(this._dbfc, this.itemIndex);
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

    amount = DatabaseFunctionClass.cartList[itemIndex].amount;
    total = DatabaseFunctionClass.cartList[itemIndex].subTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Container(
        height: 200,
        width: 400,
        color: Colors.yellow,
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
