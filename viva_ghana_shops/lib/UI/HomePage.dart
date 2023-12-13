import 'package:flutter/material.dart';
import 'package:viva_ghana_shops/Classes/EventHandler.dart';
import 'package:viva_ghana_shops/UI/HFulfilledOrders.dart';
import 'package:viva_ghana_shops/UI/HMonthlyHistory.dart';
import 'package:viva_ghana_shops/UI/HNewOrdersPage.dart';
import 'package:viva_ghana_shops/UI/HPendingOrders.dart';
import 'package:viva_ghana_shops/UI/SellingPage.dart';

import '../Classes/DatabaseFunctionClass.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getNewOrders;
  }

  int _currentIndex = 0;
  late EventHandler eventH;
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List pageList = [
    NewOrdersPage(),
    PendingOrdersPage(),
    const FulfilledOrdersPage(),
    SellingPage(),
    // const HistoryPage()
  ];
  @override
  Widget build(BuildContext context) {
    //Initializing EventH
    eventH = EventHandler(context);
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        title: Text(
          '${DatabaseFunctionClass.shop.shopName} Page',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 25,
          ),
        ),
        // leading: TextButton(
        //   child: const Icon(Icons.logout),
        //   onPressed: () {
        //     eventH.on_logout(context);
        //   },
        // ),
        actions: [
          IconButton(
            icon: Icon(Icons.inventory),
            onPressed: () {
              eventH.on_show_stock();
            },
          ),
          // GestureDetector(
          //     onTap: () {
          //       eventH.on_show_stock();
          //     },
          //     child: const CircleAvatar(
          //         radius: 30,
          //         child: Text('Stock', style: TextStyle(fontSize: 10)))),
        ],
      ),
      body: Container(
        // margin: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: PageView.builder(
            controller: PageController(),
            onPageChanged: (value) {
              setState(
                () {
                  _currentIndex = value;
                },
              );
            },
            itemCount: pageList.length,
            itemBuilder: ((context, index) {
              return pageList[_currentIndex];
            }),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.lightGreen,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.notification_add), label: 'New'),
            BottomNavigationBarItem(
                icon: Icon(Icons.pending_actions), label: 'Pending'),
            BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Fulfilled'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_business_rounded), label: 'P.O.S'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.history), label: 'Monthly History'),
          ]),
    );
  }

  // getNewOrders() async {
  //   //Change function call to get fulfilled Orders
  //   await dbfc.get_new_orders();
  // }
}
