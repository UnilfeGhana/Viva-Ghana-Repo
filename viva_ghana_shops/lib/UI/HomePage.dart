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
    HistoryPage()
  ];
  @override
  Widget build(BuildContext context) {
    //Initializing EventH
    eventH = EventHandler(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${DatabaseFunctionClass.shop.shopName} Page'),
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
                  radius: 30,
                  child: Text('Stock', style: TextStyle(fontSize: 10)))),
          GestureDetector(
              onTap: () {
                setState(() {
                  eventH.on_get_new_orders();
                  eventH.on_get_pending_orders();
                  eventH.on_get_fulfilled_orders();
                  eventH.on_get_history();
                });
              },
              child: const CircleAvatar(
                  radius: 30,
                  child: Text('Refresh', style: TextStyle(fontSize: 10))))
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
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Monthly History'),
          ]),
    );
  }
}
