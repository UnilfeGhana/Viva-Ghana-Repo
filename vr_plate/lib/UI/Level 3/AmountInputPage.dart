import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/EventHandler/Level_3_events.dart';

class AmountInputPage extends StatefulWidget {
  int medicineIndex;
  AmountInputPage({Key? key, required this.medicineIndex}) : super(key: key);

  @override
  State<AmountInputPage> createState() => _AmountInputPageState(medicineIndex);
}

class _AmountInputPageState extends State<AmountInputPage> {
  int medicineIndex;
  _AmountInputPageState(this.medicineIndex);
  int amount = 1; //Amount of medicine to add to the cart
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    L3EventHandler eventHandler = L3EventHandler(context);
    return Container(
        // height: 300,
        alignment: Alignment.center,
        child: AlertDialog(
          title: const Text('Please Select the Amount'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              countWidet(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        eventHandler.amountConfirmed(amount, medicineIndex);
                      },
                      child: const Text('Confirm')),
                  ElevatedButton(
                      onPressed: () {
                        eventHandler.canceladd();
                      },
                      child: const Text('Cancel')),
                ],
              )
            ],
          ),
        ));
  }

  Widget countWidet() {
    return Container(
        height: 90,
        width: 140,
        // color: Colors.yellow,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: 60,
                  height: 34,
                  child: Container(
                    padding: EdgeInsets.only(top: 15, left: 5, right: 5),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: '$amount', border: InputBorder.none),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (int.tryParse(value) != null) {
                          if (int.tryParse(value)! > 0) {
                            setState(() {
                              amount = int.tryParse(value)!;
                            });
                          }
                        } else {
                          setState(() {
                            amount = 0;
                          });
                        }
                      },
                    ),
                  )),
              Column(
                children: [
                  Container(
                    // width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    // color: Colors.red,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          amount += 1;
                          controller.value = TextEditingValue(text: '$amount');
                        });
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {
                          if (amount > 1) {
                            setState(() {
                              amount -= 1;
                              controller.value =
                                  TextEditingValue(text: '$amount');
                            });
                          }
                        },
                        child: const Icon(Icons.remove)),
                  ),
                ],
              )
            ]));
  }
}
