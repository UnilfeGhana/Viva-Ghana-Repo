import 'dart:ui';

import 'package:flutter/material.dart';

class SquareGradient extends StatelessWidget {
  double height, width;
  SquareGradient({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 400,
      child: Text('test'),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [0, 0.5, 1],
          colors: [
            Color.fromARGB(115, 139, 195, 74),
            Color.fromARGB(127, 76, 175, 79)
          ],
        ),
      ),
    );
  }
}
