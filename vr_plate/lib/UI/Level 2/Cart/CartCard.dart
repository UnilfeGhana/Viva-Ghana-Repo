import 'package:flutter/material.dart';
import 'package:vr_plate/Class/Local/ProductClass.dart';
import 'package:vr_plate/Class/Local/UserClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/ShopFunctions.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';
import 'package:vr_plate/Functions/EventHandler/Level_3_events.dart';
import 'package:vr_plate/Functions/GetImage.dart';

class CartCart extends StatefulWidget {
  CartClass cartItem;
  CartCart({Key? key, required this.cartItem}) : super(key: key);

  @override
  State<CartCart> createState() => _CartCartState(cartItem);
}

class _CartCartState extends State<CartCart> {
  CartClass cartItem;
  _CartCartState(this.cartItem);

  ShopFunctions shopF = ShopFunctions();
  UserFunction userF = UserFunction();
  TextEditingController controller = TextEditingController();
  bool removed = false;

  @override
  Widget build(BuildContext context) {
    L3EventHandler eventH = L3EventHandler(context);
    int itemAmount = cartItem.amount;

    return (removed)
        ? Container(
            height: 80,
            width: 600,
            color: Colors.red,
            margin: const EdgeInsets.all(10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Item Removed', style: TextStyle(fontSize: 20)),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          eventH.onCartChanged();
                          userF.addToCart(cartItem);
                          removed = false;
                        });
                      },
                      child: const Text('Undo'))
                ],
              ),
            ))
        : Container(
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
                  child: Image(
                      image:
                          GetImage().getNameLocalImage(cartItem.product.img))),
              const SizedBox(width: 5),
              /////////////////////////////////////
              ///   Section for Product Details  ///
              /////////////////////////////////////
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    cartItem.productID,
                    textAlign: TextAlign.center,
                  ),
                  Text('Sub-Total:\n GHc ${cartItem.price * cartItem.amount}'),
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
                        userF.editAmount(cartItem.productID, itemAmount);
                        controller.value =
                            TextEditingValue(text: '${cartItem.amount}');
                      });
                      eventH.onCartChanged();
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
                        padding:
                            const EdgeInsets.only(top: 10, left: 5, right: 5),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                        ),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                              hintText: '${cartItem.amount}',
                              border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (int.tryParse(value) != null) {
                              if (int.tryParse(value)! > 0) {
                                setState(() {
                                  userF.editAmount(
                                      cartItem.productID, int.tryParse(value)!);
                                });
                              } else if (int.tryParse(value)! < 1) {
                                setState(() {
                                  removed = true;
                                });
                                userF.removeFromCart(cartItem.productID);
                              }
                            } else {
                              setState(() {
                                itemAmount = 0;
                              });
                            }
                            eventH.onCartChanged();
                          },
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        if (cartItem.amount > 1) {
                          setState(() {
                            itemAmount -= 1;
                            userF.editAmount(cartItem.productID, itemAmount);
                            controller.value =
                                TextEditingValue(text: '${cartItem.amount}');
                          });
                        } else if (itemAmount == 1) {
                          setState(() {
                            removed = true;
                          });
                          userF.removeFromCart(cartItem.productID);
                        }
                        eventH.onCartChanged();
                      },
                      child: const Icon(Icons.remove)),
                ],
              )
            ]));
  }
}
