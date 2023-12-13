import 'package:flutter/material.dart';

class StockCard extends StatefulWidget {
  String medicineName;
  String value;
  String image;
  StockCard(
      {super.key,
      required this.medicineName,
      required this.value,
      required this.image});

  @override
  State<StockCard> createState() => _StockCardState(medicineName, value, image);
}

class _StockCardState extends State<StockCard> {
  String medicineName;
  String value;
  String image;
  _StockCardState(this.medicineName, this.value, this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 150,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        // border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
              ),
            ),
          ),
          Text(medicineName),
          Text(" : " + value),
        ],
      ),
    );
  }
}
