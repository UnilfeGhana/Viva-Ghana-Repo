import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/GetImage.dart';
import 'package:vr_plate/Functions/EventHandler/Level_1_events.dart';
import 'package:vr_plate/Functions/Navigation/NavigationHandler.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  NavHandler navHandler = NavHandler();
  L1EventHandler eventHandler = L1EventHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          //backgroundImage
          // Container(
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   decoration: BoxDecoration(
          //     color: Colors.grey,
          //     image: DecorationImage(
          //         image: GetImage().getLocalImage(5), fit: BoxFit.cover),
          //   ),
          // ),
          //Front Texts
          Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(height: 60),
                  Text('Our Mission',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 20),
                  Text(
                      'Get you in shape the natural way and Boost your Immune System to fight diseases, with the help of healthy foods and supplements',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  SizedBox(height: 40),
                  Text('Please Turn on your Device Location before proceeding',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ],
              )),
          //Buttons
          Positioned(
            bottom: 0,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          //Chnge to subfnction to add async and assign answer to bool
                          //If returns true the return Login Page44
                          if (await takenLocation()) {
                            navHandler.Level1Nav('Login', context);
                          } else {
                            navHandler.PopUpFailed(context,
                                'Please Enable Your Device Location in Settings');
                          }
                        },
                        child: Container(
                          height: 60,
                          child: const Center(
                              child: Text('Continue',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ))),
                          decoration:
                              const BoxDecoration(color: Colors.lightGreen),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       navHandler.Level1Nav('SignUp', context);
                    //     },
                    //     child: Container(
                    //       height: 60,
                    //       child: const Center(
                    //           child: Text('Sign Up',
                    //               style: TextStyle(
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: 20,
                    //               ))),
                    //       decoration: const BoxDecoration(
                    //           color: Color.fromARGB(255, 43, 197, 151)),
                    //     ),
                    //   ),
                    // ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  ButtonStyle? style(Color color) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
    );
  }

  Future<dynamic> takenLocation() async {
    bool hasLocation = await eventHandler.onEnableLocation(context);
    return hasLocation;
  }
}
