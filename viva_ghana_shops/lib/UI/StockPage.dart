import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/UI/Widgets/StockMedicineCardWidget.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';

import '../Classes/DatabaseFunctionClass.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late EventHandler eventH;
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventH = EventHandler(context);
    setState(() {
      eventH.on_get_stock();
    });
  }

  @override
  Widget build(BuildContext context) {
    // eventH = EventHandler(context);
    ScrollController controller = ScrollController();

    return Scaffold(
        appBar: AppBar(title: const Text('Shop Stock')),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text('Quantity of Medicines in-Stock'),
              const SizedBox(height: 20),
              ListView.builder(
                  controller: controller,
                  shrinkWrap: true,
                  itemCount: DatabaseFunctionClass.cartList.length,
                  itemBuilder: (BuildContext context, index) {
                    //You should pass the List the Medicine card widget should use
                    return StockMedicineCardWidget(
                        medicineName: (index).toString(),
                        canEdit: false,
                        itemIndex: index,
                        in_dbfc: dbfc);
                  }),
              const SizedBox(height: 20),
              const Text('Contact UniLife Ghana to refill your stock'),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
