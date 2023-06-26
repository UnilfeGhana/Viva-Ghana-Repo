import 'package:badges/badges.dart' as prefix;
import 'package:flutter/material.dart';
import 'package:vr_plate/Functions/ClassFunctions/UserFunctions.dart';
import 'package:vr_plate/Functions/EventHandler/Level_1_events.dart';
import 'package:vr_plate/Functions/EventHandler/Level_2_events.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePageViews/MemberDetailView.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePageViews/ProductView.dart';

import 'HomePageScreens/DefaultHomeScreen.dart';
import 'HomePageViews/CarouselView.dart';
import 'HomePageViews/NewMemberView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  L1EventHandler eventHandler = L1EventHandler();
  ScrollController controller = ScrollController();
  int cartItems = 0;
  List<Widget> pageList = const [
    DefaultHomeScreen(),
    NewMemberView(),
    MemberDetailView(),
  ];
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // cartItems = UserFunction.user.cartMap.values.length;
    // print('Get');
  }

  get() {
    setState(() {
      cartItems = UserFunction.user_.cartMap.values.length;
      print('Get');
    });
  }

  @override
  Widget build(BuildContext context) {
    get();
    L2EventHandler eventHandler2 = L2EventHandler(context);
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 99, 204, 0),
          backgroundColor: Colors.white,
          //     Color.fromARGB(117, 168, 250, 121),
          elevation: 0,
          toolbarHeight: 90,
          actions: [
            prefix.Badge(
                position: prefix.BadgePosition.topStart(),
                badgeContent: Text('$cartItems'),
                child: IconButton(
                    onPressed: () {
                      eventHandler2.onOpenCart();
                    },
                    icon: const Icon(Icons.shopping_bag_outlined, size: 40)))
          ],
          title: const Text('Uni-Life'),
          leading: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Logout'),
                        content: Column(children: [
                          const Text('You would be logged out of this account'),
                          ElevatedButton(
                              onPressed: () {
                                eventHandler.onLogout(context);
                              },
                              child: const Text('Confirm'))
                        ]),
                      );
                    });
              },
              icon: const Icon(Icons.exit_to_app))),
      body: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        controller: pageController,
        itemCount: pageList.length,
        itemBuilder: ((context, index) {
          return pageList[_currentIndex];
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          // backgroundColor: const Color.fromARGB(255, 43, 197, 151),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.lightGreen,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.house), label: 'Home'),
            // const BottomNavigationBarItem(
            //     icon: Icon(Icons.shopping_bag), label: 'Orders'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person_add),
                label: (UserFunction.user_.isMember)
                    ? 'Add Member'
                    : 'Become a Member'),
            // BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Support'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    controller.dispose();
  }
}
