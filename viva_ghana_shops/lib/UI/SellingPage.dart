import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/CartSystem.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/Classes/OrderClass.dart';
import 'package:viva_ghana_shops/Classes/ProductClass.dart';
import 'package:viva_ghana_shops/UI/Widgets/CartCard.dart';
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

  CartSystem cartSystem = CartSystem();

  @override
  void initState() {
    super.initState();
    //Adding all available products to cart first
    for (ProductClass product in DatabaseFunctionClass.products) {
      cartSystem.addToCart(product, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    eventH = EventHandler(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Point of Sale'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Recipient Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            textFieldFormWidget('Recipient Name', 'Name', (value) {
              setState(() {
                rName = value;
              });
            }),
            textFieldFormWidget('Recipient Phone', '+233...', (value) {
              setState(() {
                rPhone = value;
              });
            }),
            textFieldFormWidget('Member Phone', '+233...', (value) {
              setState(() {
                member = value;
              });
              print('member is: $member');
            }),
            SizedBox(height: 20),
            Text(
              'Selected Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: CartSystem.cartItems.length,
                itemBuilder: (BuildContext context, index) {
                  return CartCart(cartItem: CartSystem.cartItems[index]);
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> orderMap = {};
                for (var element in CartSystem.cartItems) {
                  orderMap
                      .addAll({element.product.productName: element.quantity});
                }
                OrderClass order = OrderClass(
                    rName,
                    rPhone,
                    orderMap,
                    cartSystem.getTotalPrice().toString(),
                    'order_db_location',
                    member);

                eventH.onSell(order);
                // eventH.on_fulfill_order(order);
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldFormWidget(
      String fieldName, String hintText, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
