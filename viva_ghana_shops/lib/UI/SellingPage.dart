import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/Classes/OrderClass.dart';
import 'package:viva_ghana_shops/Classes/ProductClass.dart';
import 'package:viva_ghana_shops/UI/Widgets/MedicineCardWidget.dart';

class SellingPage extends StatefulWidget {
  SellingPage({
    super.key,
  });

  @override
  State<SellingPage> createState() => _SellingPageState();
}

class _SellingPageState extends State<SellingPage> {
  late EventHandler eventH;
  String rName = '';
  String rPhone = '';
  String member = '';

  DatabaseFunctionClass dbfc = DatabaseFunctionClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /////Adding all Products in dbfc products to cart
    // for (var product in dbfc.products) {
    //   CartClass cartItem = CartClass(product, '0');
    //   dbfc.cartMap.addAll({product.productName: cartItem});
    // }
  }

  @override
  Widget build(BuildContext context) {
    eventH = EventHandler(context);
    ScrollController controller = ScrollController();

    return Scaffold(
        body: SingleChildScrollView(
            controller: controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Point of Sale'),
                textFieldFormWidget('Recipient Name', 'Name'),
                textFieldFormWidget('Recipient Phone', '+233...'),
                textFieldFormWidget('Member Phone', '+233...'),
                SizedBox(
                  // height: 300,
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: controller,
                      itemCount: DatabaseFunctionClass.cartList.length,
                      itemBuilder: (BuildContext context, index) {
                        return MedicineCardWidget(
                            medicineName: DatabaseFunctionClass
                                .products[index].productName,
                            canEdit: true,
                            in_dbfc: dbfc,
                            itemIndex: index);
                      }),
                ),
                Row(
                  children: [
                    const Text('Total:'),
                    Text(calculateTotal(DatabaseFunctionClass.cartList))
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      String total =
                          calculateTotal(DatabaseFunctionClass.cartList);
                      //Creating Order Map
                      Map<String, CartClass> orderMap = {};
                      //adding entries to orderMap
                      for (var element in DatabaseFunctionClass.cartList) {
                        orderMap.addAll({element.product.productName: element});
                      }
                      //Creating the Order
                      OrderClass order = OrderClass(rName, rPhone, orderMap,
                          total, 'order_db_location', member);
                      eventH.on_fulfill_order(order);
                    },
                    child: const Text('Confirm'))
              ],
            )));
  }

  calculateTotal(List<CartClass> cartItems) {
    String total = '0';
    int total_val = 0;

    for (var element in cartItems) {
      total_val += int.parse(element.subTotal);
    }
    // cartMap.entries.forEach((element) {
    //   total_val += int.parse(element.value.subTotal);
    // });
    total = total_val.toString();
    return total;
  }

  Widget textFieldFormWidget(String fieldName, String hintText) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            fieldName,
            style: const TextStyle(fontSize: 10),
          ),
          Container(
            height: 80,
            width: 250,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
              onChanged: (value) {
                //Calculating Total each time the name is changed
                setState(() {
                  calculateTotal(DatabaseFunctionClass.cartList);
                });
                String newVal = value.trim();
                switch (fieldName) {
                  case 'Recipient Name':
                    setState(() {
                      rName = newVal;
                    });
                    break;
                  case 'Recipient Phone':
                    setState(() {
                      rPhone = newVal;
                    });
                    break;
                  case 'Member Phone':
                    setState(() {
                      member = newVal;
                    });
                    break;
                  default:
                    setState(() {
                      rName = newVal;
                    });
                }
              },
              decoration: InputDecoration(
                hintText: hintText,
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
