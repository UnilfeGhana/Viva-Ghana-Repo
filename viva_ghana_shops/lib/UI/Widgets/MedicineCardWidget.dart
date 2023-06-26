import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';

class MedicineCardWidget extends StatefulWidget {
  String medicineName;
  bool canEdit;
  DatabaseFunctionClass in_dbfc;
  MedicineCardWidget(
      {super.key,
      required this.medicineName,
      required this.canEdit,
      required this.in_dbfc});

  @override
  State<MedicineCardWidget> createState() =>
      _MedicineCardWidgetState(this.medicineName, this.canEdit, this.in_dbfc);
}

class _MedicineCardWidgetState extends State<MedicineCardWidget> {
  String medicineName;
  bool canEdit;
  DatabaseFunctionClass _dbfc;
  _MedicineCardWidgetState(this.medicineName, this.canEdit, this._dbfc);
  String productName = '';
  String price = '';
  String img = '';
  String amount = '';
  String total = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productName = _dbfc.cartMap[medicineName]!.product.productName;
    price = _dbfc.cartMap[medicineName]!.product.price;
    img = _dbfc.cartMap[medicineName]!.product.img;

    amount = _dbfc.cartMap[productName]?.amount ?? '0';
    total = _dbfc.cartMap[productName]?.subTotal ?? '0';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
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
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(img), fit: BoxFit.cover)),
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
                          controller: TextEditingController(),
                          decoration: InputDecoration(
                            hintText: amount,
                          ),
                          keyboardType: TextInputType.number,
                          //Change to read only if canEdit bool is false
                          readOnly: !canEdit,
                          onChanged: (value) {
                            if (int.tryParse(value) != null) {
                              // return;
                              //////// If the value is greater than zero edit the amount
                              ////// Then edit the Sub-Total
                              if (int.tryParse(value)! > 0) {
                                setState(() {
                                  _dbfc.cartMap[productName]?.amount = value;
                                  total =
                                      _dbfc.cartMap[productName]?.subTotal ??
                                          '0';
                                });
                              }
                              ////If the value is less than 1 remove the medicine from the cart
                              ////// Then edit the Sub-Total
                              else if (int.tryParse(value)! < 1) {
                                setState(() {
                                  _dbfc.cartMap[productName]?.amount = '0';
                                  total =
                                      _dbfc.cartMap[productName]?.subTotal ??
                                          '0';
                                });
                              }
                            }
                            /////Here a non-valid value was entered so set amount to zero
                            /// Then edit the Sub-Total
                            else {
                              setState(() {
                                _dbfc.cartMap[productName]?.amount = '0';
                                total =
                                    _dbfc.cartMap[productName]?.subTotal ?? '0';
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
            )),
      ),
    );
  }
}
