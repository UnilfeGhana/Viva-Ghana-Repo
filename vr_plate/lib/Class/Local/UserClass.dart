import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vr_plate/Class/Local/ProductClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';

class UserClass {
  String uid;
  String userName;
  String phone;
  String otp;
  Map<String, CartClass> cartMap;
  bool isMember;
  UserClass(this.uid, this.userName, this.phone, this.otp, this.cartMap,
      this.isMember);
}

class CartClass {
  String productID;
  int amount;
  double price;
  ProductClass product;
  CartClass(this.productID, this.amount, this.price, this.product);
}

class OrderClass {
  String username;
  String phoneNumber;
  Map<String, CartClass> cartItems;
  String latitude;
  String longitude;
  String memberPhone = MemberFunction.member.phone;
  OrderClass(this.username, this.phoneNumber, this.cartItems, this.latitude,this.longitude);
}

class MemberClass {
  String phone;
  List<String> children;
  List<String> parents;
  String commission;
  int medicinesBought;
  MemberClass(this.phone, this.children, this.parents, this.commission,
      this.medicinesBought);
}
