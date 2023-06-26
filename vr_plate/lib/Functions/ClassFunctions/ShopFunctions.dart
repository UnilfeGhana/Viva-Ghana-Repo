import 'package:vr_plate/Class/Local/Shop.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';

import '../../Class/Local/ProductClass.dart';
import '../../Class/environment.dart';

/// This class is used to build the Shop Page
class ShopFunctions {
//
  //get Product from ID

  //getProducts
  ProductClass getProducts(int index) {
    return Shop.products[index];
  }

  ProductClass? getIDProduct(String productID) {
    return UserFunction.user_.cartMap[productID]?.product;
  }

  //getCategories
  getCategories() {}

  //getCarousel
  CarouselClass getCarousel(int index) {
    return Shop.carousel[index];
  }
}
