import 'package:flutter/material.dart';

import '../Classes/EventHandler.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String shopName = '';
  String pin = '';
  @override
  Widget build(BuildContext context) {
    EventHandler eventH = EventHandler(context);
    return Scaffold(
        //AppBar may be removed

        body: SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 40),
        Container(
          height: 150,
          width: 250,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/VivaLogo.png'),
            fit: BoxFit.cover,
          )),
        ),
        //Shop Name Field
        textFieldFormWidget('Shop Name', ''),
        const SizedBox(
          height: 20,
        ),
        //Shop Pin Field
        textFieldFormWidget('Shop Pin', 'XXXX'),
        const SizedBox(height: 30),
        ElevatedButton(
            onPressed: () {
              setState(() {
                eventH.on_login(shopName, pin);
              });
            },
            child: const Text('Continue'))
      ]),
    ));
  }

  Widget textFieldFormWidget(String fieldName, String hintText) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            fieldName,
            style: const TextStyle(fontSize: 15),
          ),
          Container(
            height: 80,
            width: 250,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            child: TextField(
              onChanged: (value) {
                String newVal = value.trim();
                switch (fieldName) {
                  case 'Shop Name':
                    setState(() {
                      shopName = newVal;
                    });
                    break;
                  case 'Shop Pin':
                    setState(() {
                      pin = newVal;
                    });
                    break;
                  default:
                    setState(() {
                      shopName = newVal;
                    });
                }
              },
              decoration: InputDecoration(
                hintText: hintText,
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
