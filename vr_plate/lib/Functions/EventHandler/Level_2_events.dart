import 'package:flutter/cupertino.dart';
import 'package:vr_plate/Class/Local/Shop.dart';
import 'package:vr_plate/Functions/Navigation/NavigationHandler.dart';

class L2EventHandler {
  NavHandler navHandler = NavHandler();
  final BuildContext _context;
  L2EventHandler(this._context);

  ///Called when a Carousel Card is selected
  onOpenCarousel(int carouselIndex) {
    navHandler.carouselLink(_context, Shop.carousel[carouselIndex].link!);
  }

  ///Called when a Product is selected
  onProductSelect(int productIndex) {
    navHandler.Lev3Nav('openProduct', _context, productIndex);
  }

  ///Event Called when Cart is Opened
  onOpenCart() {
    //Below is a discrepancy where Level 2 events open Level 2 Navigations
    navHandler.Level2Nav('Cart', _context);
  }

  ///Called when any of the Category Cards are Selected
  onCategorySelect() {}
}
