import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';
import 'package:vr_plate/Functions/EventHandler/Level_1_events.dart';
import 'package:vr_plate/Functions/Navigation/NavigationHandler.dart';

class SubmitOTPPage extends StatefulWidget {
  String verId;
  SubmitOTPPage({Key? key, required this.verId}) : super(key: key);

  @override
  State<SubmitOTPPage> createState() => _SubmitOTPPageState(this.verId);
}

class _SubmitOTPPageState extends State<SubmitOTPPage> {
  String verId;
  _SubmitOTPPageState(this.verId);
  L1EventHandler eventHandler = L1EventHandler();
  String otp = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text('Submit OTP',
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
                  'OTP',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  height: 80,
                  width: 250,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextField(
                    onChanged: (value) {
                      String newVal = value.trim();
                      setState(() {
                        otp = newVal;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Type OTP',
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
              eventHandler.onSubmitOTP(otp, verId, context);
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                )),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
