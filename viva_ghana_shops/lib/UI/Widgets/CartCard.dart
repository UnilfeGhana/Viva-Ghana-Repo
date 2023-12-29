import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/CartSystem.dart';

import '../../Classes/ProductClass.dart';

class CartCart extends StatefulWidget {
  CartClass cartItem;
  CartCart({Key? key, required this.cartItem}) : super(key: key);

  @override
  State<CartCart> createState() => _CartCartState(cartItem);
}

class _CartCartState extends State<CartCart> {
  CartClass cartItem;
  _CartCartState(this.cartItem);

  TextEditingController controller = TextEditingController();
  bool removed = false;

  @override
  Widget build(BuildContext context) {
    int itemAmount = cartItem.quantity;

    return Container(
        width: 600,
        height: 200,
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          /////////////////////////////////////
          ///       Container For Image   /////
          /////////////////////////////////////
          Container(
              height: 300,
              width: 150,
              child: Image(image: AssetImage(cartItem.product.img))),
          const SizedBox(width: 5),
          /////////////////////////////////////
          ///   Section for Product Details  ///
          /////////////////////////////////////
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                cartItem.product.productName,
                textAlign: TextAlign.center,
              ),
              Text(
                  'Sub-Total:\n GHc ${cartItem.product.price * cartItem.quantity}'),
            ],
          ),
          const SizedBox(width: 10),
          /////////////////////////////////////////////////
          ///       Column for TextField and Amount   /////
          //////////////////////////////////////////////////
          Column(
            children: [
              /////////////////////////////////////
              ///       Increase Product Count   /////
              /////////////////////////////////////
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    itemAmount += 1;
                    CartSystem().updateQuantity(cartItem.product, itemAmount);
                    controller.value =
                        TextEditingValue(text: '${cartItem.quantity}');
                  });
                },
                child: const Icon(Icons.add),
              ),

              ////////////////////////////////////////////
              ///     TextField for Product Count   /////
              ////////////////////////////////////////////
              SizedBox(
                  width: 60,
                  height: 34,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: '${cartItem.quantity}',
                          border: InputBorder.none),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (int.tryParse(value) != null) {
                          if (int.tryParse(value)! >= 0) {
                            setState(() {
                              CartSystem().updateQuantity(
                                  cartItem.product, int.parse(value));
                              itemAmount = int.parse(value);
                            });
                          }
                        } else {
                          setState(() {
                            itemAmount = 0;
                          });
                        }
                      },
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    if (cartItem.quantity > 0) {
                      setState(() {
                        itemAmount -= 1;
                        CartSystem()
                            .updateQuantity(cartItem.product, itemAmount);
                        controller.value =
                            TextEditingValue(text: '${cartItem.quantity}');
                      });
                    }
                  },
                  child: const Icon(Icons.remove)),
            ],
          )
        ]));
  }
}
