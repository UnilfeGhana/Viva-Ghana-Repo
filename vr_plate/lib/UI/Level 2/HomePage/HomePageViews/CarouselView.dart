import 'package:flutter/material.dart';
import 'package:vr_plate/Class/Local/Shop.dart';

import '../HomePageCards/CarouselCards.dart';

class CarouselView extends StatefulWidget {
  const CarouselView({Key? key}) : super(key: key);

  @override
  State<CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {
  PageController controller = PageController();
  int scrollDelay = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changePage();
  }

  @override
  Widget build(BuildContext context) {
    // print('get Carousel');
    return Container(
        height: 299,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            const Text("  We're here to help",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
            const SizedBox(height: 5),
            Container(
              height: 250,
              child: PageView.builder(
                controller: controller,
                itemCount: Shop.carousel.length,
                itemBuilder: (BuildContext context, index) {
                  return CarouselCard(CarouselIndex: index);
                },
              ),
            ),
          ],
        ));
  }

  changePage() async {
    // return;
    await Future.delayed(const Duration(seconds: 5));
    if (!controller.hasClients) {
      return;
    }
    if (controller.page == Shop.carousel.length - 1) {
      // controller.jumpTo(0);
      controller.animateToPage(0,
          duration: const Duration(milliseconds: 1500), curve: Curves.easeIn);

      await Future.delayed(Duration(seconds: scrollDelay));
      changePage();
    } else if (controller.page! >= controller.initialPage) {
      controller.nextPage(
          duration: const Duration(milliseconds: 1500), curve: Curves.easeIn);
      await Future.delayed(Duration(seconds: scrollDelay));
      changePage();
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    controller.dispose();
  }
}
