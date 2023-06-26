import 'package:flutter/cupertino.dart';
import 'package:vr_plate/Class/Local/UserClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/LocationClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/ShopFunctions.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';

import '../Navigation/NavigationHandler.dart';
import '../ServerFunctions/PlaceOrderFunction.dart';

class L3EventHandler {
  final BuildContext context;
  L3EventHandler(this.context);
  NavHandler navHandler = NavHandler();
  ShopFunctions shopF = ShopFunctions();
  UserFunction userF = UserFunction();
  LocationClass _locationClass = LocationClass();

  onCartChanged() {
    //first use a bool and on trigerreed bool is true
    //then the total card triggers setState and resets the bool to false
  }

  addToCart(int productIndex) {
    //first call the nav handler to bring up the amount dialog
    navHandler.Lev4Nav('openProductAmount', context, productIndex);
  }

  amountConfirmed(int amount, medicineIndex) {
    CartClass cart = CartClass(
        shopF.getProducts(medicineIndex).productID,
        amount,
        shopF.getProducts(medicineIndex).price,
        shopF.getProducts(medicineIndex));
    //on click confirm send the med to cart
    userF.addToCart(cart);
    navHandler.clearLayers(context);
  }

  canceladd() {
    navHandler.clearLayers(context);
  }

  // removeFromCart() {}

  viewCart() {
    //open the cart
    navHandler.Lev4Nav('Cart', context, null);
  }

  returnToHomePage() {
    navHandler.clearLayers(context);
  }

  confirmPickUp() async {
    navHandler.Lev4Nav('openPickUpPage', context, null);
    // _navHandler.PopUpLoading(context, 'Please wait');
    await _locationClass.getDeviceLocation();
    // _navHandler.clearLayers(context);
    //Text should be changed
    // _navHandler.PopUpSuccess(context, 'Successful');
    // await Future.delayed(const Duration(seconds: 1));
    // _navHandler.clearLayers(context);
    // return true;
  }

  placeOrder(String username, phoneNumber) async {
    //show please wait first
    navHandler.PopUpLoading(context, 'Placing Order');
    //Place Order at backend here
    if (await ServerPlaceorder().placeOrder(
        userF.createOrder(LocationClass.position, username, phoneNumber))) {
      //Commented below try block since commissioning is not to be done here
      //show done
      userF.emptyCart();
      navHandler.clearLayers(context);
      navHandler.clearLayers(context);
      navHandler.clearLayers(context);
      navHandler.clearLayers(context);
      navHandler.Lev4Nav('HomePage', context, null);
      navHandler.PopUpSuccess(context, 'Order Placed');
    }else {
      navHandler.clearLayers(context);
      navHandler.Lev4Nav('HomePage', context, null);
      navHandler.PopUpFailed(context, 'Failed to Place Order');
    }
  }
}
