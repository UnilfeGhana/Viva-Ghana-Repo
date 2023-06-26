import 'package:flutter/material.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePageCards/CategoriesCard.dart';

class CategoriesViews extends StatefulWidget {
  const CategoriesViews({Key? key}) : super(key: key);

  @override
  State<CategoriesViews> createState() => _CategoriesViewsState();
}

class _CategoriesViewsState extends State<CategoriesViews> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 20,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('  Categories',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            // color: Colors.grey,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (BuildContext context, index) {
                  return CategoriesCard(
                    CategoriesIndex: index,
                  );
                })),
        const SizedBox(height: 15),
      ],
    ));
  }
}
