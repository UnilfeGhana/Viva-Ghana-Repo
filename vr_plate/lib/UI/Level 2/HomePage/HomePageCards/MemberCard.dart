import 'package:flutter/material.dart';

class MemberCard extends StatefulWidget {
  String memberName;
  String memberPhone;
  MemberCard({Key? key, required this.memberName, required this.memberPhone})
      : super(key: key);

  @override
  State<MemberCard> createState() =>
      _MemberCardState(this.memberName, this.memberPhone);
}

class _MemberCardState extends State<MemberCard> {
  String memberName;
  String memberPhone;
  _MemberCardState(this.memberName, this.memberPhone);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        height: 50,
        color: Colors.white,
        width: 400,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Member Name: $memberName'),
              Text('Member Phone: $memberPhone')
            ]));
  }
}
