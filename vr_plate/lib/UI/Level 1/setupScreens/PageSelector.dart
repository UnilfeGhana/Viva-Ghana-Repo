import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/EventHandler/Level_1_events.dart';
import 'package:vr_plate/Functions/GetImage.dart';
import 'package:vr_plate/UI/Level%201/IntroScreen.dart';

class PageSelector extends StatefulWidget {
  const PageSelector({Key? key}) : super(key: key);

  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  L1EventHandler eventHandler = L1EventHandler();
  GetImage getImage = GetImage();
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    int pageIndex = 0;
    List<Widget> containers = [
      Container(
          //intro to App
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 200),
                    const Text(
                      'Welcome to UniLife',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 350),
                    ElevatedButton(
                      style: style(const Color.fromARGB(255, 43, 197, 151)),
                      onPressed: () {
                        controller.animateToPage(pageIndex + 1,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeIn);
                        // setState(() {
                        //   pageIndex += 1;
                        // });
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Text('Continue')),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          )),
      Container(
          // Flat/fit screen
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: getImage.getLocalImage(1), fit: BoxFit.cover),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 150),
              Image(
                image: GetImage().getLocalImage(7),
              ),
              const SizedBox(
                width: 300,
                child: Text(
                  'Consult Doctors Online',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Get in Touch with health professionals right here!'),
              const SizedBox(height: 200),
              ElevatedButton(
                style: style(const Color.fromARGB(255, 43, 197, 151)),
                onPressed: () {
                  controller.animateToPage(pageIndex + 1,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeIn);
                  // setState(() {
                  //   pageIndex += 1;
                  // });
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Continue')),
              ),
              const SizedBox(height: 10),
            ],
          )),
      Stack(children: [
        tint(
          MediaQuery.of(context).size.height,
          MediaQuery.of(context).size.width,
        ),
        Container(
            //delivery screen
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: getImage.getLocalImage(2), fit: BoxFit.cover),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 200),
                Expanded(
                  child: Container(
                      width: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: GetImage().getLocalImage(6),
                              fit: BoxFit.cover))),
                ),
                const Text(
                  'We deliver at your Doorstep',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      // color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                // const SizedBox(height: 600),
                const Text(
                  'Enable your location so that we can deliver straight to you',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 200),
                ElevatedButton(
                  style: style(Color.fromARGB(255, 43, 197, 151)),
                  onPressed: () async {
                    if (await eventHandler.onEnableLocation(context)) {
                      controller.animateToPage(pageIndex + 1,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeIn);
                    }
                    // eventHandler.onEnableLocation(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text('Turn on Location')),
                ),
                const SizedBox(height: 10),
              ],
            )),
      ]), //delivery
      const IntroScreen(),
    ];
    return Scaffold(
      body: //
          PageView.builder(
        controller: controller,
        itemCount: containers.length,
        itemBuilder: (context, index) {
          pageIndex = index;
          return containers[pageIndex];
        },
      ),
      //     IndexedStack(
      //   children: containers,
      //   index: pageIndex,
      // ),
    );
  }

  Widget tint(double height, width) {
    return Container(
      height: height,
      width: width,
    );
  }

  ButtonStyle? style(Color color) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
    );
  }
}
