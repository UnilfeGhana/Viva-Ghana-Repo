import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/Classes/ProductClass.dart';
import 'package:viva_ghana_shops/UI/Widgets/MedicineCardWidget.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/UI/Widgets/StockCard.dart';

import '../Classes/DatabaseFunctionClass.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late EventHandler eventH;
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List<String> keyList = DatabaseFunctionClass.shop.stock.keys.toList();
  List valueList = DatabaseFunctionClass.shop.stock.values.toList();
  List<String> imagePaths = [];

  func() async {
    // setState(() async {
    //   await eventH.on_get_stock();
    // });
    for (var key in keyList) {
      var product = DatabaseFunctionClass.products
          .firstWhere((_product) => _product.productName == key);

      imagePaths.add(product.img);
    }
    print('doing');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventH = EventHandler(context);
    setState(() {
      eventH.on_get_stock();
    });
    func();
  }

  @override
  Widget build(BuildContext context) {
    // eventH = EventHandler(context);

    return Scaffold(
        appBar: AppBar(title: const Text('Shop Stock')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Amount of Medicines in-Stock'),
            const SizedBox(height: 20),
            SizedBox(

                // height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: DatabaseFunctionClass.shop.stock.keys.length,
                    itemBuilder: (BuildContext context, index) {
                      //You should pass the List the Medicine card widget should use
                      return StockCard(
                        medicineName: keyList[index],
                        value: valueList[index],
                        image: imagePaths[index],
                      );
                    })),
            const Text('Contact UniLife Ghana to refill your stock')
          ],
        ));
  }
}
