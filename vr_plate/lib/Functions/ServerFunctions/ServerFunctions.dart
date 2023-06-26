import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vr_plate/Class/Local/UserClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';

class ServerFunctions {
  FirebaseFirestore cloud = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static late UserCredential userCredential;

  //on Success return True else False
  authenticateUser() async {
    userCredential = await firebaseAuth.signInAnonymously();
  }

  linkAccount(String verId, String smsCode) {
    AuthCredential ac =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    firebaseAuth.currentUser?.linkWithCredential(ac);
  }

  logOut() {}

  signUp() {}

  autoLogin() {}

  ///////////Member Functions ////////////
  Future<bool> isMember(String phone) async {
    DocumentSnapshot docSnapShot =
        await cloud.collection('Members').doc(phone).get();
    return docSnapShot.exists;
  }

  Future<MemberClass> getMember(String phone) async {
    MemberClass member = MemberClass('None Member', [], [], '0', 0);
    // DocumentSnapshot memberSnapshot =
    //     await cloud.collection('Members').doc(phone).get();
    // member.phone = memberSnapshot.get('phone');
    // member.children = memberSnapshot.get('children');
    // member.parents = memberSnapshot.get('parents');
    // member.commission = memberSnapshot.get('commission');
    // member.medicinesBought = memberSnapshot.get('medicinesBought');

    cloud.collection('Members').doc(phone).snapshots().listen((memberSnapshot) {
      member.phone = memberSnapshot['phone'];
      member.children = memberSnapshot['children'];
      member.parents = memberSnapshot['parents'];
      member.commission = memberSnapshot['commission'];
      member.medicinesBought = 1;
    });

    return member;
  }

  saveMemberChanges(MemberClass member) async {
    CollectionReference cloudMembers = cloud.collection('Members');
    Map<String, dynamic> membersMap = {
      'phone': member.phone,
      'children': member.children,
      'parents': member.parents,
      'commission': member.commission
    };
    await cloudMembers.doc(member.phone).update(membersMap);
  }

  sumbitNewMember(MemberClass member) async {
    CollectionReference cloudMembers = cloud.collection('Members');
    //Try and See if Member already exists on Database
    //If True then fail the process
    if (await isMember(member.phone)) {
      return false;
    }
    //If Member does not exist then add the new member
    else {
      Map<String, dynamic> membersMap = {
        'phone': member.phone,
        'children': member.children,
        'parents': member.parents,
        'commission': member.commission
      };
      await cloudMembers.doc(member.phone).set(membersMap);
      return true;
    }
  }

  submitNewChild(String phone, String name, String parentPhone) async {
    CollectionReference cloudMembers = cloud.collection('Members');

    await cloudMembers.doc(parentPhone).update({
      'new_member_buffer': phone
    });
  }

  getCommission(String phone) {
    CollectionReference cloudMembers = cloud.collection('Members');
    String commission = '';
    cloudMembers.doc(phone).snapshots().listen((event) {
      commission = event['commission'];
    });
    return commission;
  }

  //On buy product
  //Loop through all parents and increase commission by 1
  memberBuyProduct() {
    MemberFunction.member.parents.forEach((parent) {
      _increaseCommission(parent);
    });
  }

  _increaseCommission(String phone) async {
    int commission_per_sale = 4;
    //Get old commission and increase by 1
    MemberClass member = await getMember(phone);
    num comm = member.commission as num;
    num factor = 0;
    if (member.medicinesBought == 0) {
      factor = 0;
    } else if (member.medicinesBought == 1) {
      factor = 0.5;
    } else {
      factor = 1;
    }

    comm += (commission_per_sale * factor);
    member.commission = comm.toString();
    //Send new commission value to server
    saveMemberChanges(member);
  }

  ////////Shop Server Functions////////

  sGetCarousel() {
    CollectionReference carouselRef = cloud
        .collection('AppData')
        .doc('CarouseData')
        .collection('CarouseList');
  }

  sGetCategories() {}

  sGetProducts() {
    DocumentReference productRef = cloud
        .collection('AppData')
        .doc('CarouseData')
        .collection('CarouseList')
        .doc();
  }

  //boiler plate functions
  // sendOTP(String phoneNumber, BuildContext context) {
  //   firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await firebaseAuth.signInWithCredential(credential);
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //         showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                   title: const Text('Error'), content: Text('${e.message}'));
  //             });
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         verId = verificationId;
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {});
  // }

  // Future<bool> checkOTP(String otp) async {
  //   bool result = false;
  //   PhoneAuthCredential credential =
  //       PhoneAuthProvider.credential(verificationId: verId, smsCode: otp);
  //   await firebaseAuth.signInWithCredential(credential);
  //   firebaseAuth.authStateChanges().listen((event) {
  //     if (event!.getIdToken() != null) {
  //       result = true;
  //     }
  //   });
  //   return result;
  // }
}
