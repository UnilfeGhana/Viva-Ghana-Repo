import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/ClassFunctions/ShopFunctions.dart';
import 'package:vr_plate/Functions/GetImage.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePageCards/ProductCard.dart';

class CarouselDetialPage extends StatefulWidget {
  int carouselIndex;
  CarouselDetialPage({Key? key, required this.carouselIndex}) : super(key: key);

  @override
  State<CarouselDetialPage> createState() =>
      _CarouselDetialPageState(carouselIndex);
}

class _CarouselDetialPageState extends State<CarouselDetialPage> {
  int carouselIndex;
  _CarouselDetialPageState(this.carouselIndex);
  ShopFunctions shopF = ShopFunctions();
  GetImage getImage = GetImage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text('Carousel Detail')),
        body: Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Image(
                  image: getImage
                      .getNameLocalImage(shopF.getCarousel(carouselIndex).img),
                  fit: BoxFit.cover),
              color: Colors.yellow),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 54, 244, 149),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Blog Name'),
                const Text('Blog Description'),
                const Text(
                    'Longggg Text \nLongggg Text \nLongggg Text \nLongggg Text \nLongggg Text \n'),
                const Text('Medicine Below'),
                // ProductCard(productIndex: 0),
                ElevatedButton(onPressed: () {}, child: const Text('Button'))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
