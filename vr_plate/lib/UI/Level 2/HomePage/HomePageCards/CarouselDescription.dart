import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/ClassFunctions/ShopFunctions.dart';

class CarouselDescription extends StatefulWidget {
  int CarouselIndex;
  CarouselDescription({Key? key, required this.CarouselIndex})
      : super(key: key);

  @override
  State<CarouselDescription> createState() =>
      _CarouselDescriptionState(CarouselIndex);
}

class _CarouselDescriptionState extends State<CarouselDescription> {
  int CarouselIndex;
  _CarouselDescriptionState(this.CarouselIndex);

  double width = 150, maxHeight = 240;
  bool show = true;
  testF() async {
    await Future.delayed(const Duration(microseconds: 7000));
    setState(() {
      width = 150;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // testF();
  }

  @override
  Widget build(BuildContext context) {
    String title = ShopFunctions().getCarousel(CarouselIndex).title,
        subtitle = ShopFunctions().getCarousel(CarouselIndex).subtitle;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      // onEnd: () {
      //   setState(() {
      //     show = true;
      //   });
      // },
      height: maxHeight,
      padding: const EdgeInsets.only(left: 10),
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(20)),
        color: Color.fromARGB(171, 169, 255, 71),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: maxHeight / 4),
          const Spacer(flex: 3),
          Text(
            title,
            style: TextStyle(
              fontSize: (show) ? 20 : 0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(subtitle,
              style: TextStyle(
                fontSize: (show) ? 15 : 0,
                color: Colors.black,
              )),
          const Spacer(flex: 2),
          // SizedBox(height: maxHeight / 6),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   mainAxisSize: MainAxisSize.max,
          //   children: const [
          //     Text('learn more',
          //         style: TextStyle(color: Color.fromARGB(255, 240, 41, 41))),
          //     Icon(Icons.arrow_forward_rounded,
          //         color: Color.fromARGB(255, 240, 41, 41), size: 20),
          //   ],
          // ),
          // const SizedBox(height: 10)
          // const Spacer(flex: 1)
        ],
      ),
    );
  }
}
