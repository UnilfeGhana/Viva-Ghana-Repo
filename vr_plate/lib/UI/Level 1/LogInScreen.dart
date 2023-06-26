import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';
import 'package:vr_plate/Functions/EventHandler/Level_1_events.dart';
import 'package:vr_plate/UI/Level%201/OTPpage.dart';

import '../../Functions/Navigation/NavigationHandler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  L1EventHandler eventHandler = L1EventHandler();
  UserFunction user = UserFunction();
  NavHandler navHandler = NavHandler();
  @override
  Widget build(BuildContext context) {
    //Initializing OTP bool in UserFunction Class
    UserFunction.otpSent = false;
    String phone = '';
    return Scaffold(
      // appBar: AppBar(title: const Text('Login')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text('Viva Life\nLogin/Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 100),
          //SizedBox for Phone Number field
          SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Phone',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  ' +233',
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  height: 80,
                  // decoration: const BoxDecoration(
                  //     border: Border(
                  //         bottom:
                  //             BorderSide(width: 2, color: Colors.lightGreen))),
                  width: 250,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      String newVal = value.trim();
                      newVal = newVal.split('+233')[1];
                      newVal = newVal.split('0')[1];
                      newVal = '+233' + newVal;
                      setState(() {
                        phone = newVal;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'xx-xxxx-xxx',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                eventHandler.onLogin(context, 'otp', phone);
              });
              // String verId = eventHandler.onSubmitPhone(phone);
              // if (verId != 'NULL') {
              //   Navigator.of(context)
              //       .push(MaterialPageRoute(builder: (BuildContext context) {
              //     return SubmitOTPPage(verId: verId);
              //   }));
              // } else {
              //   navHandler.PopUpFailed(
              //       context, 'Wrong Phone Number \nID: $verId \n');
              // }
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18),
                )),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  ButtonStyle? style(Color color) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
      // side: MaterialStateBorderSide()
    );
  }
}
