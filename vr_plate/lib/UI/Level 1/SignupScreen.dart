// import 'package:flutter/material.dart';
// import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';
// import 'package:vr_plate/Functions/GetImage.dart';
// import 'package:vr_plate/Functions/EventHandler/Level_1_events.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   UserFunction user = UserFunction();
//   L1EventHandler eventHandler = L1EventHandler();
//   bool canLogin = false;
//   @override
//   Widget build(BuildContext context) {
//     //Initializing OTP bool in UserFunction Class
//     UserFunction.otpSent = false;
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//             // color: Colors.lightGreen,
//             // image: DecorationImage(image: GetImage().getLocalImage(1)),
//             ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //Container for Username
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: TextField(
//                 onChanged: (value) => setState(() {
//                   user.setUserName(value);
//                 }),
//                 decoration: InputDecoration(
//                     labelText: 'User Name',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: const BorderSide())),
//               ),
//             ),
//             //Container for Password
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//               child: TextField(
//                 onSubmitted: (value) => setState(() {
//                   user.setPhone(value, context);
//                 }),
//                 decoration: InputDecoration(
//                     labelText: 'Phone:(+233-xx-xxxx-xxx)',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: const BorderSide())),
//               ),
//             ),
//             //Container for otp
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//               child: TextField(
//                 onSubmitted: (value) async {
//                   bool temp = await user.checkOTP(value);
//                   setState(() {
//                     canLogin = temp;
//                   });
//                 },
//                 decoration: InputDecoration(
//                     labelText: 'OTP',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: const BorderSide())),
//               ),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   if (canLogin) {
//                     eventHandler.onSignUp(context);
//                   }
//                 },
//                 child: const Text('Sign Up')),
//             Container(
//                 child: const Center(
//               child: Text(
//                   (true) ? ('Please wait for OTP to be sent...') : ('OTP sent'),
//                   style: TextStyle(decoration: TextDecoration.underline)),
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
