import 'package:flutter/material.dart';
import 'package:vr_plate/Class/Local/UserClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';
import 'package:vr_plate/Functions/EventHandler/Level_3_events.dart';

import 'CartCard.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartClass> cart = UserFunction.user_.cartMap.values.toList();
  double total = 0;

  @override
  Widget build(BuildContext context) {
    L3EventHandler eventHandler = L3EventHandler(context);
    ScrollController controller = ScrollController();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart Page')),
      body: (cart.isEmpty)
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Cart is Empty\nPlease add an Item to Continue'),
                  ElevatedButton(
                      onPressed: () {
                        eventHandler.returnToHomePage();
                      },
                      child: const Text('Return to Home Screen'))
                ],
              ),
            )
          : SingleChildScrollView(
              controller: controller,
              child: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView.builder(
                      controller: controller,
                      itemCount: cart.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartCart(cartItem: cart[index]);
                      }),
                ),
                SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Card(
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Amount: GHc ${UserFunction.total}'),
                          ElevatedButton.icon(
                              onPressed: () {
                                eventHandler.confirmPickUp();
                              },
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text('Select Delivery Location'))
                        ],
                      ),
                    ))
              ]),
            ),
    );
  }
}
