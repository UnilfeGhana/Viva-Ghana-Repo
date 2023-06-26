import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/DatabaseFunctionClass.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/Classes/ProductClass.dart';
import 'package:viva_ghana_shops/UI/Widgets/MedicineCardWidget.dart';

import '../Classes/OrderClass.dart';

class OrderDetailsPage extends StatefulWidget {
  OrderClass order;
  OrderDetailsPage({super.key, required this.order});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState(this.order);
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  OrderClass order;
  _OrderDetailsPageState(this.order);

  //Create DatabaseFunctionClass and edit the Cart map to contain the values you want
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Adding the Medicines in the Order to the cartmap of this dbfc
    order.orders.entries.forEach((medicine) {
      int productIndex = DatabaseFunctionClass()
          .products
          .indexWhere((product) => product.productName == medicine.key);
      String price_of_medicine =
          (DatabaseFunctionClass().products[productIndex].price);
      String img = (DatabaseFunctionClass().products[productIndex].img);
      ProductClass product = ProductClass(medicine.key, price_of_medicine, img);
      CartClass cartItem = CartClass(product, medicine.value.toString());
      dbfc.cartMap.addAll({medicine.key: cartItem});
    });
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
                      );
                    })),
            //For spacing
            const SizedBox(height: 20),
            Row(
              children: [const Text('Total:'), Text(order.total)],
            ),

            ElevatedButton(
                onPressed: () {
                  EventHandler(context).on_pend_order(order);
                },
                child: const Text('Pend Order'))
          ],
        ),
      ),
    );
  }
}
