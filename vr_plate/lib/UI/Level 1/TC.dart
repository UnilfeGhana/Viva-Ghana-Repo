import 'package:flutter/material.dart';
import '../Level 1/TCclass.dart';

class TCpage extends StatelessWidget {
  TCpage({Key? key}) : super(key: key);
  String tc = TC().tc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(child: Column(children: [Text(tc)]))),
    );
  }
}
