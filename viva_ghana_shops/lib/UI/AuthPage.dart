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
  Color green = Color.fromARGB(255, 92, 216, 60);
  @override
  Widget build(BuildContext context) {
    EventHandler eventH = EventHandler(context);
    return Scaffold(
        //AppBar may be removed
        // appBar: AppBar(
        //     title: const Text(
        //   'Welcome to Viva Shops',
        //   textAlign: TextAlign.center,
        // )),
        body: Stack(alignment: Alignment.topCenter, children: [
      Positioned(
        // top: 0,
        child: Container(
          color: green,
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 35),
          child: const Text('Viva Shops\n Login',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                // color: Colors.white,
              )),
        ),
      ),
      Positioned(
        // top: 200,
        child: Container(
          // height: double.infinity,
          margin: const EdgeInsets.only(top: 250),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 248, 248, 248),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(

              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('Please Login'),
                const SizedBox(height: 100),

                //Shop Name Field
                textFieldFormWidget('Shop Name', 'Shop Name'),
                const SizedBox(
                  height: 20,
                ),
                //Shop Pin Field
                textFieldFormWidget('Shop Pin', 'Shop Pin'),
                const SizedBox(height: 60),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(green)),
                    onPressed: () {
                      print(shopName);
                      print(pin);
                      setState(() {
                        eventH.on_login(shopName, pin);
                      });
                    },
                    child: const Text('        Continue        '))
              ]),
        ),
      ),
    ]));
  }

  Widget textFieldFormWidget(String fieldName, String hintText) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   fieldName,
          //   style: const TextStyle(fontSize: 15),
          // ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(width: 0.2),
            ),
            elevation: 0,
            child: Container(
              height: 65,
              width: 340,
              decoration: BoxDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                    hintText: hintText, border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
