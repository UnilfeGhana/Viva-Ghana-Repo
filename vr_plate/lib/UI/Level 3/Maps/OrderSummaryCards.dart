import 'package:flutter/material.dart';
import 'package:vr_plate/Class/Local/UserClass.dart';

import '../../../Functions/ClassFunctions/UserFunctions.dart';

class OrderSummary extends StatelessWidget {
  ScrollController controller;
  OrderSummary({Key? key, required this.controller}) : super(key: key);

  List<CartClass> products = UserFunction.user_.cartMap.values.toList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // shrinkWrap: true,
            // controller: controller,
            itemCount: products.length,
            itemBuilder: ((BuildContext context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                height: 100,
                width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image(
                        image: AssetImage(products[index].product.img),
                      ),
                      width: 100,
                      height: 100,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Medicine: ${products[index].productID}'),
                        Text('Price: ${products[index].price}'),
                        Text('Number: ${products[index].amount}')
                      ],
                    )
                  ],
                ),
              );
            })));
  }
}
