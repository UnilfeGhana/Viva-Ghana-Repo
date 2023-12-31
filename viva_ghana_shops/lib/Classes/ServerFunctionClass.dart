import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:viva_ghana_shops/Classes/MemberClass.dart';
import 'package:viva_ghana_shops/Classes/ServerKeys.dart';

import 'DatabaseFunctionClass.dart';
import 'OrderClass.dart';
import 'ShopClass.dart';

class ServerFunctionClass {
  static FirebaseFirestore cloud = FirebaseFirestore.instance;

  String shopsLocation = 'Shops';
  String ordersLocation = 'Orders';
  ServerKeysClass skc = ServerKeysClass();

  Future<List<DocumentSnapshot>> getDocuments(
      String collectionName, shopName, pin, orderType) async {
    String _shopName = shopName;
    String _pin = pin;
    try {
      CollectionReference collection = FirebaseFirestore.instance
          .collection(collectionName)
          .doc('$_shopName:$_pin')
          .collection(orderType);

      QuerySnapshot querySnapshot = await collection.get();

      return querySnapshot.docs;
    } catch (e) {
      print("Error getting documents: $e");
      return [];
    }
  }

  Future<ShopClass> get_shop(String shopName, String pin) async {
    //First get Shop Snapshot from the database
    //Get various list of orders from the shop to pass to the ShopClass variable
    List<OrderClass>? newOrders = [];
    // await get_shop_new_orders(shopName, pin);
    List<OrderClass>? pendingOrders = [];
    // await get_shop_pending_orders(shopName, pin);
    List<OrderClass>? fulfilledOrders = [];
    // await get_shop_fulfilled_orders(shopName, pin);
    List<OrderClass>? history = await get_shop_history(shopName, pin);

    ////////////////////////////////////////////
    ///     Using Listener to Get Info       //
    ///////////////////////////////////////////
    ///
    print('Shop Id is: $shopName:$pin');

    ////Shop Pending Orders SnapShot Listener

    //Listener to get shop Mobile

    ////////////////////////////////////////////
    ///       End of Listener                //
    ///////////////////////////////////////////

    //Create ShopClass varaible and fill with necessary Information
    Map<String, dynamic> map = {};
    ShopClass shop = ShopClass(shopName, pin, 'mobile', map, newOrders,
        pendingOrders, fulfilledOrders, history!, [], 'shopSnapShot.id');

    //return ShopClass varaible shop
    return shop;
  }

  get_shop_stock(String shopName, String pin) async {
    Map<String, dynamic> stock = {};
    DocumentSnapshot data =
        await cloud.collection(shopsLocation).doc('$shopName:$pin').get();

    stock = data[skc.stock];
    // DatabaseFunctionClass.shop.stock = stock;
    return stock;
  }

  Future<List<OrderClass>?> get_shop_new_orders(
      String shopName, String pin) async {
    List<OrderClass> newOrders = [];
    print(shopName);
    List<DocumentSnapshot<Object?>> values =
        await getDocuments('Shops', shopName, pin, 'new_orders');

    for (var orderMap in values) {
      //Converting Medicine List to Map//////
      List<dynamic> testList = orderMap[skc.medicines];

      Map<int, dynamic> tmap = testList.asMap();
      Map<String, dynamic> nmap = {};
      for (var i = 0; i < tmap.length; i++) {
        String nameBuffer = tmap[i][skc.medicineName];

        nameBuffer = nameBuffer.replaceFirst(RegExp(r'\n'), ' ');

        nmap.addAll({nameBuffer: tmap[i][skc.medicineNumber]});
      }
      OrderClass _order = OrderClass(
          orderMap[skc.recipient],
          orderMap[skc.phone],
          nmap,
          orderMap[skc.total].toString(),
          orderMap.id,
          orderMap[skc.member]);

      //First Checking to see if Order has already been loaded
      if (DatabaseFunctionClass.shop.shop_new_orders.contains(_order)) {
        //Saving the orders to Shop's Orders
      } else {
        newOrders.add(_order);
      }
      // print(newOrders[0].orders);
    }

    print(newOrders[0].total);
    return newOrders;
  }

  Future<List<OrderClass>?> get_shop_pending_orders(
      String shopName, String pin) async {
    List<OrderClass> pendingOrders = [];
    List<DocumentSnapshot<Object?>> val =
        await getDocuments('Shops', shopName, pin, 'pending_orders');

    for (var orderMap in val) {
      // Map<String, dynamic> tmap = orderMap[skc.medicines];
      Map<String, dynamic> nmap = orderMap[skc.medicines];
      print(nmap);

      OrderClass _order = OrderClass(
          orderMap[skc.recipient],
          orderMap[skc.phone],
          nmap,
          orderMap[skc.total].toString(),
          orderMap.id,
          orderMap[skc.member]);

      //First Checking to see if Order has already been loaded
      if (DatabaseFunctionClass.shop.shop_pending_orders.contains(_order)) {
        //Saving the orders to Shop's Orders
      } else {
        pendingOrders.add(_order);
      }
      // print(newOrders[0].orders);
    }
    return pendingOrders;
  }

  Future<List<OrderClass>?> get_shop_fulfilled_orders(
      String shopName, String pin) async {
    List<OrderClass> fulfilledOrders = [];
    List<DocumentSnapshot> val =
        await getDocuments('Shops', shopName, pin, 'fulfilled_orders');
    for (var orderMap in val) {
      Map<String, dynamic> nmap = orderMap[skc.medicines];

      print(nmap);
      OrderClass _order = OrderClass(
        orderMap[skc.recipient],
        orderMap[skc.phone],
        nmap,
        orderMap[skc.total].toString(),
        orderMap.id,
        orderMap[skc.phone],
      );
      // print(_order);
      //First Checking to see if Order has already been loaded
      if (DatabaseFunctionClass.shop.shop_fulfilled_orders.contains(_order)) {
        //Saving the orders to Shop's Orders
      } else {
        fulfilledOrders.add(_order);
      }
      // fulfilledOrders.add(_order);
      // print(fulfilledOrders);
    }
    return fulfilledOrders;
  }

  Future<List<OrderClass>?> get_shop_failed_orders(
      String shopName, String pin) async {
    List<OrderClass> failedOrders = [];
    try {
      cloud
          .collection(shopsLocation)
          .doc('$shopName:$pin')
          .collection('failed_orders')
          .snapshots()
          .listen((event) {
        for (DocumentSnapshot order in event.docs) {
          //Converting Medicine List to Map//////
          List<dynamic> testList = order[skc.medicines];
          // testList.add(order['Medicines']);
          Map<int, dynamic> tmap = testList.asMap();
          Map<String, dynamic> nmap = {};
          for (var i = 0; i < tmap.length; i++) {
            nmap.addAll(
                {tmap[i][skc.medicineName]: tmap[i][skc.medicineNumber]});
          }
          //End of Conversion//////////////
          //Creating a variable to store current iterated order
          OrderClass _order = OrderClass(order[skc.recipient], order[skc.phone],
              nmap, '0', order.id, order[skc.member]);
          //Saving the Orders to fulfilled Orders
          failedOrders.add(_order);
        }
      });
    } catch (e) {
      print('No Fulfilled Orders');
    }
    return failedOrders;
  }

  Future<List<OrderClass>?> get_shop_history(
      String shopName, String pin) async {
    List<OrderClass> history = [];

    try {
      cloud
          .collection(shopsLocation)
          .doc('$shopName:$pin')
          .collection('history')
          .snapshots()
          .listen((event) {
        for (DocumentSnapshot order in event.docs) {
          //Converting Medicine List to Map//////
          List<dynamic> testList = order[skc.medicines];

          Map<int, dynamic> tmap = testList.asMap();
          Map<String, dynamic> nmap = {};
          for (var i = 0; i < tmap.length; i++) {
            nmap.addAll(
                {tmap[i][skc.medicineName]: tmap[i][skc.medicineNumber]});
          }
          //End of Conversion//////////////
          //Creating a variable to store current iterated order
          OrderClass _order = OrderClass(order[skc.recipient], order[skc.phone],
              nmap, '0', order.id, order[skc.member]);
          //Savingthe current iterated order to the history Orders List
          history.add(_order);
        }
      });
    } catch (e) {
      print('No history');
    }

    return history;
  }

  //////////////////////////////

  update_shop_stock(Map<String, dynamic> stock, String shopName, String pin) {
    Map<String, dynamic> new_stock = stock;
    cloud
        .collection(shopsLocation)
        .doc('$shopName:$pin')
        .update({'stock': new_stock});
  }

  // on_clear_pending_order(OrderClass order, String shopName, String pin) {
  //   cloud
  //       .collection(shopsLocation)
  //       .doc('$shopName:$pin')
  //       .collection('pending_orders')
  //       .doc(order.order_db_location)
  //       .delete();
  // }

////////////////////////////////////////////////
  ///           Commissioning             //////
////////////////////////////////////////////////

  on_commission(OrderClass order) async {
    //get the member's phone from the order
    // MemberClass member;
    // getMember('+233555713127').then(
    //   (value) {
    //     member = value;
    //     memberBuyProduct(member);
    //   },
    // );
    new_onCommission(order);

    //On Commission, get each parent of the phone number without having to take the full member
    //Then send each of those parents to member buy product
  }

///////////////////////////////////////////////////
  ///     New Method to Handle Commissioning    ///
///////////////////////////////////////////////////
  new_onCommission(OrderClass order) async {
    String memberPhone = order.memberPhone;
    DocumentSnapshot memberSnapshot =
        await cloud.collection('Members').doc(memberPhone).get();
    List<String> parents = memberSnapshot['parents'];

    for (var parent in parents) {
      DocumentSnapshot parent_member =
          await cloud.collection('Members').doc(parent).get();
      String parent_comm = parent_member['commission'];
      _increaseCommission(parent, parent_comm, 1);
    }
  }

  Future<MemberClass> getMember(String phone) async {
    phone = '+233555713127';
    MemberClass member = MemberClass('None Member', [], [], '', 0);
    DocumentSnapshot memberSnapshot =
        await cloud.collection('Members').doc(phone).get();
    print('Member Snapshot is:$memberSnapshot');
    String phone_ = memberSnapshot['phone'];
    List<String> children = memberSnapshot['children'];
    List<String> parents = memberSnapshot['parents'];
    String commission = memberSnapshot['commission'];
    //Should be changed back to memberSnapshot['medicinesBought']
    int medicinesBought = 1;

    member.phone = phone_;
    member.children = children;
    member.parents = parents;
    member.commission = commission;
    member.medicinesBought = medicinesBought;

    return member;
  }

  saveMemberChanges(MemberClass member) async {
    CollectionReference cloudMembers = cloud.collection('Members');
    Map<String, dynamic> membersMap = {
      'phone': member.phone,
      'children': member.children,
      'parents': member.parents,
      'commission': member.commission
    };
    await cloudMembers.doc(member.phone).update(membersMap);
  }

  memberBuyProduct(MemberClass member) {
    member.parents.forEach((parent) {
      //Update: Pass the complete Memeber as an Argument to _increaseCommission
      _increaseCommission(parent, member.commission, member.medicinesBought);
    });
  }

  _increaseCommission(
      String phone, String memberCommission, int medicinesBought) async {
    int commission_per_sale = 4;
    //Get old commission and increase by 1
    num comm = memberCommission as num;
    // num factor = 0;
    // if (medicinesBought == 0) {
    //   factor = 0;
    // } else if (medicinesBought == 1) {
    //   factor = 0.5;
    // } else {
    //   factor = 1;
    // }

    //Hard Setting the factor regardless of conditions  Should Be Removed
    int factor = 1;

    comm += (commission_per_sale * factor);
    var new_comm = comm.toString();
    memberCommission = new_comm;
    print("New Commission is $new_comm");
    //Send new commission value to server
    MemberClass member = await getMember(phone);
    saveMemberChanges(member);
  }

//////////////////////////////////////////////
  ///           End of Commissioning    /////
//////////////////////////////////////////////

  Future<String> on_create_order(
      OrderClass order, String shopName, String pin) async {
    Map<String, dynamic> orderMap = {
      'Recipient': order.recipientName,
      'Phone': order.recipientPhone,
      'Medicines': [order.orders],
      'Total': order.total,
      'Member Phone': order.memberPhone,
    };

    List<Map<String, dynamic>> list = [];

    print('it is: ${order.orders}');

    // return ' ';

    for (int x = 0; x < order.orders.keys.length; x++) {
      list.add({
        'Medicine Name': order.orders.keys.toList()[x],
        'Number': order.orders.values.toList()[x],
      });
    }

    Map<String, dynamic> cloudCart = {
      'Recipient': order.recipientName,
      'Phone': order.recipientPhone,
      'Total': order.total,
      'Medicines': list,
      'Member Phone': order.memberPhone,
    };

    DocumentReference id = await cloud
        .collection(shopsLocation)
        .doc('$shopName:$pin')
        .collection('new_orders')
        .add(cloudCart);

    return id.id;
  }

  on_pend_order(OrderClass order, String shopName, String pin) async {
    //Creating Order Map variable
    Map<String, dynamic> orderMap = {
      'Recipient': order.recipientName,
      'Phone': order.recipientPhone,
      'Medicines': order.orders,
      'Total': order.total,
      'Member Phone': order.memberPhone,
    };
    print('order ID is :');
    print(order.order_db_location);

    //Deleting Order from New Orders Collection
    cloud
        .collection(shopsLocation)
        .doc('$shopName:$pin')
        .collection('new_orders')
        .doc(order.order_db_location)
        .delete();

    //Adding order to Pending Orders Collection
    cloud
        .collection(shopsLocation)
        .doc('$shopName:$pin')
        .collection('pending_orders')
        .add(orderMap);
  }

  on_fulfill_order(OrderClass order, String shopName, String pin) async {
    print("test: ${order.memberPhone}");
    //Creating Order Map variable
    Map<String, dynamic> orderMap = {
      'Recipient': order.recipientName,
      'Phone': order.recipientPhone,
      'Medicines': order.orders,
      'Total': order.total
    };

    print('Order is is ${order.order_db_location}');

    //Deleting Order from New Orders Collection
    cloud
        .collection(shopsLocation)
        .doc('$shopName:$pin')
        .collection('pending_orders')
        .doc(order.order_db_location)
        .delete();

    //Adding order to Pending Orders Collection
    cloud
        .collection(shopsLocation)
        .doc('$shopName:$pin')
        .collection('fulfilled_orders')
        .add(orderMap);

    //////////////////////////////////////////////////////////////////
    ///    COMMISSIONING  Send the Quantity of Medicines Ordered /////
    //////////////////////////////////////////////////////////////////
    ///
    print('helo');
    int total_goods_ordered = 0;

    print(order.orders.values);
    for (int amount in order.orders.values.toList()) {
      total_goods_ordered += amount;
      print('amount is $amount');
    }

    print('totalGoods is: $total_goods_ordered');

    print('from member: ${order.memberPhone}');

    cloud.collection('Members').doc(order.memberPhone).update(
        {'commission': '${order.order_db_location}:${total_goods_ordered}'});

    ////////////////////////////////////////////////////
    ///   Showing a Member has purchased at least 1  ///
    ////////////////////////////////////////////////////
    ///
    cloud
        .collection('Members')
        .doc(order.memberPhone)
        .update({'medicinesBought': '1'});

    ///Below is deprecated

    ///Send Commission notification for each medicine in order

    // cloud
    //     .collection('Members')
    //     .doc(order.memberPhone)
    //     .update({'commission': order.order_db_location});

    // for (var medicine in order.orders.values) {
    //   for (int i = 0; i < medicine['Number']; i++) {
    //     cloud
    //         .collection('Members')
    //         .doc(order.memberPhone)
    //         .update({'commission': '${order.order_db_location}$i'});
    //   }
    // }
  }

  on_fail_order(OrderClass order, String shopName, String pin) async {
    //Creating Order Map variable
    Map<String, dynamic> orderMap = {
      'Recipient': order.recipientName,
      'Phone': order.recipientPhone,
      'Medicines': order.orders,
      'Total': order.total
    };

    print('order id: ${order.order_db_location}');

    //Deleting Order from pending Orders Collection
    cloud
        .collection(shopsLocation)
        .doc('$shopName:$pin')
        .collection('pending_orders')
        .doc(order.order_db_location)
        .delete();

    //Adding order to failed Orders Collection
    cloud
        .collection(shopsLocation)
        .doc('$shopName:$pin')
        .collection('failed_orders')
        .add(orderMap);
  }

  /////////////////////////////

  on_logout() {}
}
