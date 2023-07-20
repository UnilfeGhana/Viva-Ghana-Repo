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
    setState(
      () {
        MemberFunction().getCommission();
        MemberFunction().getMember();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //Add Viva Plus Background Picture here
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.white,
                )),
            // color: Colors.grey
          ),
          const SizedBox(height: 20),
          //Container to Contain member Phone
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Phone: +'),
                Text(MemberFunction().getMemberPhone()),
              ],
            ),
          ),
          const SizedBox(height: 20),
          //Container for Commission
          Container(
              child: Row(
            children: [
              const Text('Commission Due:  '),
              Text(
                MemberFunction().getMemberCommission(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const Text(' GHC'),
            ],
          )),

          const SizedBox(height: 40),
          //Container to Contain List of Member Children
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              'Children: (${MemberFunction().getMemberChildren().length})',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          ListView.builder(
              controller: controller,
              shrinkWrap: true,
              itemCount: MemberFunction().getMemberChildren().length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 30,
                    color: Colors.lightGreen,
                    alignment: Alignment.center,
                    child: Text(MemberFunction().getMemberChildren()[index],
                        style: const TextStyle(color: Colors.white)),
                  ),
                );
              }),
        ]),
      ),
    );
  }
}
