import 'package:flutter/material.dart';
import 'package:vr_plate/Class/Local/Shop.dart';

import '../HomePageCards/ProductCard.dart';

class ProductView extends StatelessWidget {
  ScrollController controller;
  ProductView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.lightGreen,
      // height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text('  Recommended',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          ListView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              itemCount:
                  Shop.products.length, //get Number from List of product Length
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                return ProductCard(
                  productIndex: index,
                  controller: controller,
                );
              }),
        ],
      ),
    );
  }
}
