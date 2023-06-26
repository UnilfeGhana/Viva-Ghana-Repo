import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vr_plate/UI/Level%201/L1screenExport.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//To Implement Duplicate this Project and delete the google-services.json file
//Also change the name of the app which is 'com.example...' to your desired appName
//Add your app to the Firebase Console

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viva Ghana',
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
      home: const IntroScreen(),
    );
  }
}
//Deciding to stop at level 4 navigation since beyond that there is not really a
// lot of pages to navigate from there
//also the maps page and 'Amount Input' Page are on the same level according to 
//the folders

//Planning on adding chat feature so patients can message their Doctors
//----------------
//New Plans
//----------------

//---Set up stock feature for Shops and only choose valid close shops
//---Copy Auth Page UI and paste at Shop Auth Page

//---Later Setup screen for users to see past orders



//----Redundant/Make the app take new information from backend all the time
//On Add Member please send otp to new member to verify for their consent
//On Login please send otp to confirm

//Make "send_otp" function return "verId" and pass that ID to the "check_otp" function to be able to verify

//Add indicator to show that otp has been sent---------
//Make sure new users can be added--------
//Make Adding of Already Existing Users Idempotent----------
//Change expression to add ancestors to new member---------------
//Make every user a member---***
//Work on Anonymous Sign In methods----***
//Add Member Screen to see Children and Member Commission details------***