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
  int _currentIndex = 0;
  late EventHandler eventH;
  DatabaseFunctionClass dbfc = DatabaseFunctionClass();
  List pageList = [
    NewOrdersPage(),
    PendingOrdersPage(),
    FulfilledOrdersPage(),
    SellingPage(),
    // HistoryPage()
  ];
  @override
  Widget build(BuildContext context) {
    //Initializing EventH
    eventH = EventHandler(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Orders'),
        leading: TextButton(
          child: Icon(Icons.logout),
          onPressed: () {
            eventH.on_logout(context);
          },
        ),
        actions: [
          GestureDetector(
              onTap: () {
                eventH.on_show_stock();
              },
              child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('Stock', style: TextStyle(fontSize: 10)))),
        ],
      ),
      body: PageView.builder(
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
      bottomNavigationBar: BottomNavigationBar(
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
                icon: Icon(Icons.new_releases), label: 'New Orders'),
            BottomNavigationBarItem(
                icon: Icon(Icons.pending_actions), label: 'Pending Orders'),
            BottomNavigationBarItem(
                icon: Icon(Icons.done), label: 'Fulfilled Orders'),
            BottomNavigationBarItem(
                icon: Icon(Icons.create), label: 'Create Order'),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.history), label: 'Monthly History'),
          ]),
    );
  }
}
