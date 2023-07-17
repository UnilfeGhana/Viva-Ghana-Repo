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
  String phone = '';
  @override
  Widget build(BuildContext context) {
    //Initializing OTP bool in UserFunction Class
    UserFunction.otpSent = false;
    String phone = '';
    return Scaffold(
      // appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text('Viva Life\nLogin/Sign Up ~2.0',
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
                    width: 230,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        String newVal = value.trim();
                        newVal = newVal..replaceFirst(RegExp(r'\+233'), '');
                        newVal = newVal.replaceFirst(RegExp(r'0'), '');
                        newVal = newVal.trim();

                        newVal = '233$newVal';
                        setState(() {
                          phone = newVal;
                          UserFunction.user_.phone = phone;
                          MemberFunction().setMemberPhone(phone);
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
                print("Debug memberPhone is ${UserFunction.user_.phone}");
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
