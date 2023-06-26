import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/ClassFunctions/ShopFunctions.dart';
import 'package:vr_plate/Functions/EventHandler/Level_2_events.dart';
import 'package:vr_plate/Functions/GetImage.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePageCards/CarouselDescription.dart';

class CarouselCard extends StatefulWidget {
  int CarouselIndex;
  CarouselCard({Key? key, required this.CarouselIndex}) : super(key: key);

  @override
  State<CarouselCard> createState() => _CarouselCardState(this.CarouselIndex);
}

class _CarouselCardState extends State<CarouselCard> {
  int CarouselIndex;
  _CarouselCardState(this.CarouselIndex);

  ShopFunctions shopF = ShopFunctions();

  double maxHeight = 240;

  @override
  Widget build(BuildContext context) {
    String image = shopF.getCarousel(CarouselIndex).img;
    L2EventHandler eventHandler = L2EventHandler(context);

    return GestureDetector(
      onTap: () => eventHandler.onOpenCarousel(CarouselIndex),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.lightGreen,
        ),
        height: maxHeight,
        width: 350,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            //Image
            Container(
              height: maxHeight,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 201, 199, 199),
                image: DecorationImage(
                  image: GetImage().getNameLocalImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //Description
            Positioned(
                right: 0,
                child: CarouselDescription(
                  CarouselIndex: CarouselIndex,
                )),
          ],
        ),
      ),
    );
  }
}
