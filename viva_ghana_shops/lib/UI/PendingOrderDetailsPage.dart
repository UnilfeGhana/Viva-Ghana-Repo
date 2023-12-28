import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/Classes/ProductClass.dart';
import 'package:viva_ghana_shops/UI/Widgets/MedicineCardWidget.dart';

import '../Classes/OrderClass.dart';

class PendingOrderDetailsPage extends StatefulWidget {
  OrderClass order;
  PendingOrderDetailsPage({super.key, required this.order});

  @override
  State<PendingOrderDetailsPage> createState() =>
      _PendingOrderDetailsPageState(this.order);
}

class _PendingOrderDetailsPageState extends State<PendingOrderDetailsPage> {
  OrderClass order;
  _PendingOrderDetailsPageState(this.order);

  //Create DatabaseFunctionClass and edit the Cart map to contain the values you want
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Adding the Medicines in the Order to the cartmap of this dbfc
    // order.orders.entries.forEach((medicine) {
    //   int productIndex = DatabaseFunctionClass()
    //       .products
    //       .indexWhere((product) => product.productName == medicine.key);
    //   String price_of_medicine =
    //       (DatabaseFunctionClass().products[productIndex].price);
    //   String img = (DatabaseFunctionClass().products[productIndex].img);
    //   ProductClass product = ProductClass(medicine.key, price_of_medicine, img);
    //   CartClass cartItem = CartClass(product, medicine.value.toString());
    //   dbfc.cartMap.addAll({medicine.key: cartItem});
    // });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            ////Recipient Name
            Row(
              children: [
                const Text('Recipient Name: '),
                Text(order.recipientName),
              ],
            ),
            Row(
              children: [
                const Text('Recipient Phone: '),
                Text(order.recipientPhone)
              ],
            ),
            SizedBox(
                height: 400,
                child: ListView.builder(
                    controller: controller,
                    itemCount: order.orders.keys.toList().length,
                    itemBuilder: (
                      BuildContext context,
                      index,
                    ) {
                      return MedicineCardWidget(
                          medicineName: order.orders.keys.toList()[index],
                          //  'Viva Plus (90)',
                          canEdit: false,
                          in_dbfc: dbfc,
                          itemIndex: index);
                    })),
            //For spacing
            const SizedBox(height: 20),
            Row(
              children: [const Text('Total:'), Text(order.total)],
            ),
            /////////On Fulfill Order
            ElevatedButton(
                onPressed: () {
                  EventHandler(context).on_fulfill_order(order);
                },
                child: const Text('Completed')),

            //For spacing
            const SizedBox(height: 10),
            /////////On Fail Order
            ElevatedButton(
                onPressed: () {
                  EventHandler(context).on_fail_order(order);
                },
                child: const Text('Fail Order'))
          ],
        ),
      ),
    );
  }
}
