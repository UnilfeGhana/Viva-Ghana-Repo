import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vr_plate/Class/Local/UserClass.dart';
import 'package:vr_plate/Functions/ServerFunctions/ServerFunctions.dart';

class UserFunction {
  static UserClass user_ =
      UserClass('uid', 'userName', '0000000000', 'password', {});
  static List<OrderClass> orders = [];
  static double total = 0;
  static bool otpSent = false;
  // final NavHandler _navHandler = NavHandler();

  //Authentication Dependecies
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static String verId = 'NULL';

  //intialize

  // listener(){
  //   StreamSubscription sub = Stream()
  // }

  setUserName(String userName) {
    user_.userName = userName;
  }

  setPhone(String phone) {
    user_.phone = phone;
    // _sendOTP(phone, context);
  }

  setOTP(String otp) {
    user_.otp = otp;
  }

  get getPhone {
    return user_.phone;
  }

  get getUsername {
    return user_.userName;
  }

  String sendOTP(String phoneNumber) {
    String verificationID = 'NULL';
    // _navHandler.PopUpLoading(context, 'Sending OTP');
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          // _navHandler.clearLayers(context);
          verId = verificationId;
          verificationID = verificationId;
          otpSent = true;
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
    return verificationID;
  }

  Future<bool> checkOTP(String otp, String verId) async {
    bool result = false;
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: otp);
    await firebaseAuth.signInWithCredential(credential);
    firebaseAuth.authStateChanges().listen((event) {
      if (event!.getIdToken() != null) {
        result = true;
      }
    });
    return result;
  }

  logout() {
    user_ = UserClass('uid', 'userName', '0000000000', 'password', {});
    MemberFunction().reset();
    total = 0;
  }

  addToCart(CartClass item) {
    if (user_.cartMap.containsKey(item.productID)) {
      user_.cartMap[item.productID]!.amount += item.amount;
      total += ((item.price) * item.amount);
    } else {
      user_.cartMap.addAll({item.productID: item});
      total += ((item.price) * item.amount);
    }
  }

  removeFromCart(String item) {
    total -= ((user_.cartMap[item]?.price)! * (user_.cartMap[item]?.amount)!);
    user_.cartMap.remove(item);
  }

  editAmount(String item, int amount) {
    double price = (user_.cartMap[item]?.price)!;

    total = (amount < user_.cartMap[item]!.amount)
        ? total - (((user_.cartMap[item]!.amount) - amount) * price)
        : total + ((amount - (user_.cartMap[item]!.amount)) * price);
    user_.cartMap[item]?.amount = amount;
  }

  emptyCart() {
    user_.cartMap.clear();
    total = 0;
  }

  OrderClass createOrder(Position position, String username, phoneNumber) {
    OrderClass order = OrderClass(username, phoneNumber, user_.cartMap,
        '${position.latitude}', '${position.longitude}');
    orders.add(order);
    //then send to the backend
    return order;
  }
}

class MemberFunction {
  static MemberClass _member =
      MemberClass(UserFunction.user_.phone, [], [], '0', 0);

  ServerFunctions serverFunctions = ServerFunctions();

  MemberFunction() {
    _member.phone = UserFunction.user_.phone;
    setMemberCommission();
    getMember();
  }

  getMember() async {
    _member = await ServerFunctions().getMember(_member.phone);
  }

  setMemberPhone(String phone) {
    _member.phone = phone;
  }

  setMemberCommission() async {
    _member.commission = await ServerFunctions().getCommission(_member.phone);
  }

//////////////////////////////////
  ///   Getters             /////
//////////////////////////////////
  String getMemberPhone() {
    String phone = _member.phone;
    return phone;
  }

  List getMemberChildren() {
    List visibleChildren = [];
    // for (int child = _member.children.length; child > 0; child--) {
    //   String phone = _member.children[child];
    //   visibleChildren.add('+$phone');
    // }
    for (int i = 1; i < _member.children.length; i++) {
      String phone = _member.children[i];
      print("Debug Adding phone");
      visibleChildren.add('+$phone');
    }
    print("Debug visible is $visibleChildren");
    return visibleChildren;
  }

  String getMemberCommission() {
    setMemberCommission();
    print('Debug Member Commission is ${_member.commission}');
    String commission_cedis = '${_member.commission}.00';
    return commission_cedis;
  }

  List getMemberParents() {
    return _member.parents;
  }

//Default functions
  addChild(String phone) {
    _member.children.add(phone);
  }

  addParent(String phone) {
    _member.parents.add(phone);
  }

  getCommission() {
    return _member.commission;
  }

  reset() {
    MemberFunction._member =
        MemberClass(UserFunction.user_.phone, [], [], '0', 0);
  }

//Member Functions
///////////////////////////////////////////
  ///     Send Http Request to Server     ///
///////////////////////////////////////////
  // http_submitMember(String memberPhone, String parentPhone) async {
  //   String phone = memberPhone;
  //   // String medicinesBought = member.medicinesBought.toString();
  //   Map<String, dynamic> parametersMap = {
  //     'parent_phone': parentPhone,
  //     'member_phone': phone,
  //     'member_name': 'Name'
  //   };

  //   String url =
  //       'https://us-central1-copy-1-dfbcf.cloudfunctions.net/addMember_http_func';
  //   return await makeRequest(url, parametersMap);
  // }

  //////////////////////////////////
  ///   Http request          //////
  //////////////////////////////////
  // Future<bool> makeRequest(
  //     String endpoint, Map<String, dynamic> parameters) async {
  //   final Uri uri = Uri.parse(endpoint);
  //   final http.Response response = await http.post(uri, body: parameters);

  //   if (response.statusCode == 200) {
  //     // Request successful
  //     print('Request successful');
  //     print('Response body: ${response.body}');
  //     return true;
  //   } else {
  //     // Request failed
  //     print('Request failed');
  //     print('Status code: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     return false;
  //   }
  // }

  addMember(String phone, String name) {
    addChild(phone);
    int limit = (_member.parents.length < 2) ? _member.parents.length : 3;
    MemberClass newMember = MemberClass(phone, [], [], '0', 0);
    //Add all ancestors except farthest one including the parent to the new
    for (var i = 0; i < limit - 1; i++) {
      //This means that the farthest ancestor would be skipped until the last
      //Meaning only 2 out of the 3 parents of the parent would be added to the new Member
      //This is done before the parent itself is added as a parent making 3 new parents in total
      newMember.parents.add(_member.parents[i + 1]);
    }
    newMember.parents.add(_member.phone);

    //Next create new Database file for member
    bool succesful = serverFunctions.sumbitNewMember(newMember);
    if (succesful) {
      serverFunctions.saveMemberChanges(_member);
      return true;
    }
    return false;
  }

  pushNewMember(String phone, String name, String parentPhone) {
    serverFunctions.submitNewChild(phone, name, parentPhone);
  }

  buyProduct() {
    //Should be done on the pharma shops not on Viva Ghana App
    // for (var medicine in UserFunction.user.cartMap.keys) {
    //   serverFunctions.memberBuyProduct();
    // }
  }
}
