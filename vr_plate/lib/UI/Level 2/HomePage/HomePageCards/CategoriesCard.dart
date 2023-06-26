import 'package:flutter/material.dart';

class CategoriesCard extends StatefulWidget {
  int CategoriesIndex;
  CategoriesCard({Key? key, required this.CategoriesIndex}) : super(key: key);

  @override
  State<CategoriesCard> createState() =>
      _CategoriesCardState(this.CategoriesIndex);
}

class _CategoriesCardState extends State<CategoriesCard> {
  int CategoriesIndex;
  _CategoriesCardState(this.CategoriesIndex);

  double size = 35;
  Color color = const Color.fromARGB(255, 71, 146, 0);

  List<IconData> iconData = [
    Icons.bloodtype,
    Icons.monitor_heart,
    Icons.medication,
    Icons.remove_red_eye,
    Icons.phone,
    Icons.local_hospital,
  ];

  List<String> texts = [
    'Blood pressure',
    'Heart Rate',
    'Medication',
    'Eye medication',
    'Contact',
    'Hospital',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(117, 168, 250, 121),
      ),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Icon(iconData[CategoriesIndex], size: size, color: color),
          const SizedBox(height: 10),
          Text(texts[CategoriesIndex],
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const Text('Specialist',
              style: TextStyle(
                  color: Color.fromARGB(255, 104, 104, 104), fontSize: 12)),
        ],
      )),
    );
  }
}
