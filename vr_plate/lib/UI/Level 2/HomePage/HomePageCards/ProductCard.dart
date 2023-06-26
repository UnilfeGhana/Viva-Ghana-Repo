import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/ClassFunctions/ShopFunctions.dart';
import 'package:vr_plate/Functions/EventHandler/Level_2_events.dart';
import 'package:vr_plate/Functions/GetImage.dart';

class ProductCard extends StatefulWidget {
  int productIndex;
  ScrollController controller;
  ProductCard({Key? key, required this.productIndex, required this.controller})
      : super(key: key);

  @override
  State<ProductCard> createState() =>
      _ProductCardState(productIndex, controller);
}

class _ProductCardState extends State<ProductCard> {
  int productIndex;
  ScrollController controller;
  ShopFunctions shopF = ShopFunctions();

  _ProductCardState(this.productIndex, this.controller);
  @override
  Widget build(BuildContext context) {
    //
    L2EventHandler eventHandler = L2EventHandler(context);
    GetImage getImage = GetImage();

    String productName = shopF.getProducts(productIndex).productName;
    double price = shopF.getProducts(productIndex).price;
    String img = shopF.getProducts(productIndex).img;
    String description = shopF.getProducts(productIndex).description;
    List<String> shortDescriptions =
        shopF.getProducts(productIndex).shortDescription;

    return GestureDetector(
      onTap: () {
        eventHandler.onProductSelect(productIndex);
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: SizedBox(
            height: 200,
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //////////////////////////////////////////////////
                ///         SizedBox for Medicine Image       ////
                //////////////////////////////////////////////////
                SizedBox(
                  child: Container(
                    height: 250,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.contain,
                    )),
                  ),
                ),
                /////////////////////////////////////////////////////
                ///     Container for Medicine Details and Info  ////
                /////////////////////////////////////////////////////
                Container(
                  height: 250,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      /////////////////////////////////////////////////////
                      ///       Text for Medicine Name            ////////
                      /////////////////////////////////////////////////////
                      Text(
                        productName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      /////////////////////////////////////////////////////
                      ///       Text for Medicine Short Info           ////
                      /////////////////////////////////////////////////////
                      ListView.builder(
                          shrinkWrap: true,
                          controller: controller,
                          itemCount: shortDescriptions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return productShort(shortDescriptions[index]);
                          }),
                      //////////////////////////////////////////////////////
                      ///       Text for Medicine Call To Action        ////
                      //////////////////////////////////////////////////////
                      ElevatedButton(
                          onPressed: () {
                            eventHandler.onProductSelect(productIndex);
                          },
                          child: const Text('Know more'))
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Row productShort(String info) {
    return Row(
      children: [
        const SizedBox(width: 5),
        const Icon(Icons.circle, size: 5),
        Text(' $info',
            style: const TextStyle(color: Color.fromARGB(255, 95, 95, 95))),
      ],
    );
  }
}
