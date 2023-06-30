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
        height: 200,
        color: Colors.white,
        width: 400,
        child: Row(children: [
          Text('Member Name: $memberName'),
          Text('Member Phone: $memberPhone')
        ]));
  }
}
