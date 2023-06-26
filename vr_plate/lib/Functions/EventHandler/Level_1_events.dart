import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vr_plate/Class/Local/UserClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/LocationClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';
import 'package:vr_plate/Functions/Navigation/NavigationHandler.dart';
import 'package:vr_plate/Functions/ServerFunctions/ServerFunctions.dart';

class L1EventHandler {
  final NavHandler _navHandler = NavHandler();
  final UserFunction _userFunction = UserFunction();
  final ServerFunctions _sFunctions = ServerFunctions();
  final LocationClass _locationClass = LocationClass();
  FirebaseFirestore cloud = FirebaseFirestore.instance;
  autoLogin() {}

  onLogin(BuildContext context, String otp, String phone) async {
    UserFunction userF = UserFunction();
    _locationClass.getDeviceLocation();
    // UserFunction.total = 0;
    userF.setPhone(phone);
    UserFunction.user_.phone = phone;
    //first validate _sFunctions.authenticateUser()
    //Make every Login a Member here
    _navHandler.Level2Nav('HomePage', context);

    //This should be changed back to the isValid bool
    // _navHandler.clearLayers(context);
    _navHandler.PopUpSuccess(context, 'Successfully Logged In');
    //Check if User Already exists

    // if (await _sFunctions.isMember(UserFunction.user_.phone)) {
    //   MemberFunction.member =
    //       await _sFunctions.getMember(UserFunction.user_.phone);
    //   UserFunction.user_.isMember = true;
    // } else {
    //   MemberClass member =
    //       MemberClass(UserFunction.user_.phone, [], [], '0', 0);
    //   MemberFunction.member = member;
    //   _sFunctions.sumbitNewMember(member);
    // }

    MemberFunction().pushNewMember(phone, 'name', '000');

    return;
  }

//Below functions should replace straight forward login function
  onSubmitPhone(String phone) {
    String verId = '';
    UserFunction().setPhone(phone);
    verId = _userFunction.sendOTP(phone);
    return verId;
  }

  onSubmitOTP(String otp, String verId, BuildContext context) async {
    UserFunction.user_.otp = otp;
    bool correct = await _userFunction.checkOTP(otp, verId);
    if (correct) {
      _navHandler.Level2Nav('HomePage', context);
    } else {
      _navHandler.PopUpFailed(context, 'Wrong OTP');
    }
  }

  onSignUp(BuildContext context) async {
    UserFunction.total = 0;
    //Below functions should be wrapped in {_sFunctions.signUp()}
    //first authenticate
    if (true) {
      _navHandler.Level2Nav('HomePage', context);
    }
    return;
  }

  onAddNewMember(UserClass user, BuildContext context) {
    MemberFunction mf = MemberFunction();
    _navHandler.clearLayers(context);
    _navHandler.Level2Nav('HomePage', context);
    // bool success = mf.addMember(user.phone, user.userName);
    bool success = mf.pushNewMember(
        user.phone, user.userName, MemberFunction.member.phone);
    // mf.http_submitMember(user.phone, MemberFunction.member.phone);
    if (success) {
      return _navHandler.PopUpSuccess(context, 'Successful');
    } else {
      return _navHandler.PopUpFailed(context, 'Member Already Exists');
    }
  }

  onLogout(BuildContext context) {
    _navHandler.clearLayers(context);
    _navHandler.clearLayers(context);
    _userFunction.logout();
    _navHandler.Level1Nav('Login', context);
    _sFunctions.logOut();
  }

  Future<bool> onEnableLocation(BuildContext context) async {
    _navHandler.PopUpLoading(context, 'Please wait');
    await _locationClass.getDeviceLocation();
    _navHandler.clearLayers(context);
    //Text should be changed
    _navHandler.PopUpSuccess(context, 'Successful');
    await Future.delayed(const Duration(seconds: 1));
    _navHandler.clearLayers(context);
    return true;
  }
}
