import 'package:flutter/material.dart';
import 'package:vr_plate/Class/Local/UserClass.dart';
import 'package:vr_plate/Functions/EventHandler/Level_1_events.dart';

class NewMemberView extends StatefulWidget {
  const NewMemberView({Key? key}) : super(key: key);

  @override
  State<NewMemberView> createState() => _NewMemberViewState();
}

class _NewMemberViewState extends State<NewMemberView> {
  UserClass user = UserClass('', '', '', '', {}, false);
  L1EventHandler eventHandler = L1EventHandler();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // color: Colors.lightGreen,
          // image: DecorationImage(image: GetImage().getLocalImage(1)),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Container for Title of Page
          const Text('Add a New Member to Earn Monthly',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          //Container for Username
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  user.userName = value;
                });
              },
              decoration: InputDecoration(
                  labelText: 'New Member\'s Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide())),
            ),
          ),
          //Container for Password
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  user.phone = value;
                });
              },
              decoration: InputDecoration(
                  labelText: 'New Member\'s Phone: +233-xx-xxxx-xxx',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide())),
            ),
          ),
          //Container for otp
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          //   child: TextField(
          //     onSubmitted: (value) => user.checkOTP(value),
          //     decoration: InputDecoration(
          //         labelText: 'OTP',
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(20),
          //             borderSide: const BorderSide())),
          //   ),
          // ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  eventHandler.onAddNewMember(user, context);
                });
              },
              child: const Text('Add Member'))
        ],
      ),
    );
  }
}
