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
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)),
                  elevation: 20,
                  child: SizedBox(
                    height: double.infinity,
                    width: 115,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      color: Colors.green,
                      strokeWidth: 10,
                      backgroundColor: Color.fromARGB(255, 235, 235, 235),
                      value: (double.parse(
                              MemberFunction().getMemberCommission()) /
                          1000),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Text(
                    "GHC ${MemberFunction().getMemberCommission()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            //  Icon(
            //   Icons.person,
            //   size: 70,
            //   color: Colors.white,
            // ),
          ),
          // color: Colors.grey

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

          const SizedBox(height: 30),
          //Container to Contain List of Member Children
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(
              'Referrals: (${MemberFunction().getMemberChildren().length})',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          ListView.builder(
              controller: controller,
              shrinkWrap: true,
              itemCount: MemberFunction().getMemberChildren().length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  title: Text(MemberFunction().getMemberChildren()[index]),
                  leading: CircleAvatar(child: Text("${index + 1}")),
                );
              }),
          const SizedBox(height: 10),
          const Text(
              '**Commissions will be paid automatically at the end of each month',
              style: TextStyle(
                color: Colors.green,
              )),
        ]),
      ),
    );
  }
}
