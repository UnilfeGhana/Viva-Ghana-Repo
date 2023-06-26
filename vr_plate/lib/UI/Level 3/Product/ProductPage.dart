// // ignore_for_file: must_be_immutable

// import 'package:badges/badges.dart' as prefix;
// import 'package:flutter/material.dart';
// import 'package:vr_plate/Functions/ClassFunctions/ShopFunctions.dart';
// import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';
// import 'package:vr_plate/Functions/EventHandler/Level_3_events.dart';
// import 'package:vr_plate/Functions/GetImage.dart';

// class ProductPage extends StatefulWidget {
//   int ProductIndex;
//   ProductPage({Key? key, required this.ProductIndex}) : super(key: key);

//   @override
//   State<ProductPage> createState() => _ProductPageState(ProductIndex);
// }

// class _ProductPageState extends State<ProductPage> {
//   int ProductIndex;

//   _ProductPageState(this.ProductIndex);
//   ShopFunctions shopF = ShopFunctions();
//   GetImage getImage = GetImage();
//   double mainHeight = 1000;
//   ScrollController controller = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     L3EventHandler eventHandler = L3EventHandler(context);
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(shopF.getProducts(ProductIndex).productName),
//           backgroundColor: Colors.white,
//           toolbarHeight: 60,
//           actions: [
//             prefix.Badge(
//                 position: prefix.BadgePosition.topStart(),
//                 badgeContent:
//                     Text(UserFunction.user.cartMap.values.length.toString()),
//                 child: IconButton(
//                     onPressed: () {
//                       // eventHandler.;
//                     },
//                     icon: const Icon(Icons.shopping_bag_outlined)))
//           ]),
//       body: Container(
//         height: MediaQuery.of(context).size.height * 0.9,
//         color: Colors.red,
//         child: Stack(children: [
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: mainHeight / 4,
//               // height: func(),
//               child: Image(
//                 image: getImage
//                     .getNameLocalImage(shopF.getProducts(ProductIndex).img),
//               ),
//             ),
//           ),
//           DraggableScrollableSheet(
//               snap: true,
//               initialChildSize: 0.6,
//               maxChildSize: 0.85,
//               minChildSize: 0.50,
//               builder: (BuildContext context, controller) {
//                 return Container(
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20)),
//                     color: Color.fromARGB(255, 210, 244, 200),
//                   ),
//                   child: ListView(
//                     physics: const BouncingScrollPhysics(),
//                     controller: controller,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 40, vertical: 1.9),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const SizedBox(height: 25),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                     shopF.getProducts(ProductIndex).productName,
//                                     style: const TextStyle(
//                                       fontSize: 35,
//                                       fontWeight: FontWeight.w500,
//                                     )),
//                                 Container(
//                                     alignment: Alignment.center,
//                                     padding: const EdgeInsets.all(3),
//                                     width: 110,
//                                     child: Text(
//                                         'GHc ${shopF.getProducts(ProductIndex).price.truncate()}',
//                                         style: const TextStyle(fontSize: 20)),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           width: 3, color: Colors.lightGreen),
//                                       borderRadius: BorderRadius.circular(20),
//                                     ))
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                             Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text('Description', style: subtitle()),
//                                   const Text(
//                                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in')
//                                 ]),
//                             const SizedBox(height: 20),
//                             Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text('Instruction', style: subtitle()),
//                                   Text(
//                                       '-Lorem ipsum dolor sit amet, consectetur adipiscing elit, \n-sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n -Ut enim ad minim veniam, quis nostrud exercitation ullamco\n -laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in',
//                                       style: body())
//                                 ]),
//                             const SizedBox(height: 20),
//                             Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text('Composition', style: subtitle()),
//                                   Text(
//                                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in',
//                                       style: body())
//                                 ]),
//                             const SizedBox(height: 60),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   // ), //This should be removed if the tests works
//                 );
//               }),
//           Positioned(
//             bottom: 0,
//             child: Container(
//               alignment: Alignment.center,
//               height: 50,
//               width: MediaQuery.of(context).size.width,
//               color: Colors.white,
//               child: ElevatedButton(
//                   onPressed: () {
//                     eventHandler.addToCart(ProductIndex);
//                   },
//                   child: const Text('         Purchase          ')),
//             ),
//           )
//         ]),
//       ),
//     );
//   }

//   TextStyle subtitle() {
//     return const TextStyle(
//       fontSize: 30,
//       fontWeight: FontWeight.w400,
//       decoration: TextDecoration.underline,
//       // fontStyle: FontStyle.italic
//     );
//   }

//   TextStyle body() {
//     return const TextStyle(
//       letterSpacing: 0.5,
//     );
//   }
// }
