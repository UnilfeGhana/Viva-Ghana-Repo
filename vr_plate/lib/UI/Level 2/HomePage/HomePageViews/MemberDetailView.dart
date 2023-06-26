import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';

class MemberDetailView extends StatefulWidget {
  const MemberDetailView({Key? key}) : super(key: key);

  @override
  State<MemberDetailView> createState() => _MemberDetailViewState();
}

class _MemberDetailViewState extends State<MemberDetailView> {
  ScrollController controller = ScrollController();

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
        //Add Viva Plus Background Picture here
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child:const Text('Member Profile')
          // color: Colors.grey
        ),
        const SizedBox(height: 20),
        //Container to Contain member Phone
        Container(
          child: Row(
            children: [
              const Text('Member Phone: '),
              Text(MemberFunction.member.phone),
            ],
          ),
        ),
        const SizedBox(height: 20),
        //Container for Commission
          Container(
            child: Row(
          children: [
            const Text('Commission : '),
            Text(MemberFunction.member.commission)
          ],
        )),
        
        
        const SizedBox(height: 20),
        //Container to Contain List of Member Children
        const SizedBox(
          child:Text('Children')
        ),
        ListView.builder(
            controller: controller,
            shrinkWrap: true,
            itemCount: MemberFunction.member.children.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(MemberFunction.member.children[index]),
              );
            }),
        
      ]),
    );
  }
}
