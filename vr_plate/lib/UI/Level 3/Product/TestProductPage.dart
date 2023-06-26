// ignore_for_file: must_be_immutable

//This Screen is a duplicate of the Original "Product Page" but without the Stack Implementation
//This is Because it seems the Stack made the whole page appear blank

import 'package:badges/badges.dart' as prefix;
import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/ClassFunctions/ShopFunctions.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';
import 'package:vr_plate/Functions/EventHandler/Level_3_events.dart';
import 'package:vr_plate/Functions/GetImage.dart';

class NewProductPage extends StatefulWidget {
  int ProductIndex;
  NewProductPage({Key? key, required this.ProductIndex}) : super(key: key);

  @override
  State<NewProductPage> createState() => _NewProductPageState(ProductIndex);
}

class _NewProductPageState extends State<NewProductPage> {
  int ProductIndex;

  _NewProductPageState(this.ProductIndex);
  ShopFunctions shopF = ShopFunctions();
  GetImage getImage = GetImage();
  double mainHeight = 1000;
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    L3EventHandler eventHandler = L3EventHandler(context);
    return Scaffold(
        appBar: AppBar(
            title: Text(shopF.getProducts(ProductIndex).productName),
            toolbarHeight: 60,
            actions: [
              prefix.Badge(
                  position: prefix.BadgePosition.topStart(),
                  badgeContent:
                      Text(UserFunction.user_.cartMap.values.length.toString()),
                  child: IconButton(
                      onPressed: () {
                        eventHandler.viewCart();
                      },
                      icon: const Icon(Icons.shopping_bag_outlined, size: 15)))
            ]),
        body: SingleChildScrollView(
          /////////////////////////////////////
          ///        Column for Body       /////
          /////////////////////////////////////
          child: Column(
            children: [
              //////////////////////////////////////////////////
              ///       Container for Image  Section       /////
              //////////////////////////////////////////////////
              Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: GetImage().getNameLocalImage(
                              shopF.getProducts(ProductIndex).img)))),

              //////////////////////////////////////////////////
              ///        SizedBox for Product Details      /////
              //////////////////////////////////////////////////
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Container(
                    height: 200,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(shopF.getProducts(ProductIndex).description,
                            textAlign: TextAlign.center, style: body()),
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              /////////////////////////////////////////////
              ///     Container for Purchase Button   /////
              /////////////////////////////////////////////
              Container(
                alignment: Alignment.center,
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: ElevatedButton(
                    onPressed: () {
                      eventHandler.addToCart(ProductIndex);
                    },
                    child: const Text('         Purchase          ')),
              )
            ],
          ),
        )

        // ),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     eventHandler.addToCart(ProductIndex);
        //   },
        //   child: Container(
        //     alignment: Alignment.center,
        //     height: 50,
        //     width: MediaQuery.of(context).size.width,
        //     color: Colors.white,
        //     child: ElevatedButton(
        //         onPressed: () {
        //           eventHandler.addToCart(ProductIndex);
        //         },
        //         child: const Text('         Purchase          ')),
        //   ),
        // ),
        );
  }

  TextStyle subtitle() {
    return const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.underline,
        color: Colors.black
        // fontStyle: FontStyle.italic
        );
  }

  TextStyle body() {
    return const TextStyle(
      letterSpacing: 0.5,
    );
  }
}
