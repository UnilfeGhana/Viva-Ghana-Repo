import 'package:flutter/material.dart';
import 'package:vr_plate/Class/Local/UserClass.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePageViews/CarouselView.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePageViews/CategoriesViews.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePageViews/NewMemberView.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePageViews/ProductView.dart';

class DefaultHomeScreen extends StatefulWidget {
  const DefaultHomeScreen({Key? key}) : super(key: key);

  @override
  State<DefaultHomeScreen> createState() => _DefaultHomeScreenState();
}

class _DefaultHomeScreenState extends State<DefaultHomeScreen> {
  ScrollController controller = ScrollController();
  MemberFunction mf = MemberFunction();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      child: Column(
        mainAxisSize:MainAxisSize.max,
        children: [
          const CarouselView(),
          const CategoriesViews(),
          ProductView(
            controller: controller,
          ),
        ],
      ),
    );
  }
}
