import 'package:flutter/cupertino.dart';

class ProductClass {
  String productName;
  String productID;
  double price;
  String img;
  String description;
  List<String> shortDescription;
  String composition;
  String instruction;
  // List<String> medInfo;

  ProductClass(this.productName, this.productID, this.price, this.description,
      this.img, this.shortDescription, this.composition, this.instruction);
}

class CarouselClass {
  String title;
  String subtitle;
  String img;
  String? destination;
  String? link;
  CarouselClass(this.title, this.subtitle, this.img, this.link);
}

class CategoriesClass {
  String name;
  IconData iconData;
  String subtitle;

  CategoriesClass(this.name, this.iconData, this.subtitle);
}
