import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/UI/AuthPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viva Ghana Shops',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
      ),
      home: const AuthPage(),
    );
  }
}

//Write Server Functions for the following:
//TO commission parents

//Pause commission updates at the end of the month

//Increase Number of Fulfilled Orders by a Shop

//Change a Shops Category based on fulfilledOrders

//Update
//Add buttons to refresh page to load orders
//Also allow TextField in Creating Orders Work
//Later do revamping

//Please make sure to see that the correct index is sent to the Medicine Card Widget
//In the cases of the previously generated orders since the index of the way the medicine
// is arranged does not mean that was the index in the generated orders
//To fix this try and get the index of a medicine "where product.product_name = 'Viva Lady...'"
//This format would get the index of the 'specified viva lady in the Database function Class
//and rather use this new found index as the argument to be passed into the MedicineCardWidget itemIndex