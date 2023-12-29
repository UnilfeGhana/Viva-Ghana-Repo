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
  final String version = '9.0';
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
              height: 20,
            ),
            Container(
              height: 150,
              width: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/VivaLogo.png'),
                fit: BoxFit.cover,
              )),
            ),

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
                  // const Text(
                  //   ' +233',
                  //   style: TextStyle(fontSize: 15),
                  // ),
                  Container(
                    height: 80,
                    width: 230,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        String newVal = value.trim();
                        newVal = cleanPhoneNumber(newVal);
                        newVal = '233$newVal';
                        setState(() {
                          phone = newVal;
                          UserFunction.user_.phone = phone;
                          MemberFunction().setMemberPhone(phone);
                        });
                        print('Login: $newVal');
                      },
                      decoration: const InputDecoration(
                        hintText: '+233-xx-xxxx-xxx',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('By continuing you agree to our '),
                    TextButton(
                        onPressed: () {
                          eventHandler.openTermsandConditions(context);
                        },
                        child: const Text('Terms and Conditions'))
                  ]),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                print("Debug memberPhone is ${UserFunction.user_.phone}");
                setState(() {
                  eventHandler.onLogin(context, 'otp', phone);
                });
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            const SizedBox(height: 10),
            Text(
              '~v$version',
              style: const TextStyle(fontSize: 10),
            ),
            const SizedBox(height: 10)
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

  String cleanPhoneNumber(String phoneNumber) {
    // Define the regular expression pattern
    RegExp regExp = RegExp(r"^(0|\+233)");

    // Remove the matching pattern from the phone number
    return phoneNumber.replaceAll(regExp, "");
  }
}
