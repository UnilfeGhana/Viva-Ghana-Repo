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
    try {
      CollectionReference collection = FirebaseFirestore.instance
          .collection(collectionName)
          .doc('${shopName}:${pin}')
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
    List<OrderClass>? newOrders = await get_shop_new_orders(shopName, pin);
    List<OrderClass>? pendingOrders =
        await get_shop_pending_orders(shopName, pin);
    List<OrderClass>? fulfilledOrders =
        await get_shop_fulfilled_orders(shopName, pin);
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
    ShopClass shop = ShopClass(shopName, pin, 'mobile', map, newOrders!,
        pendingOrders!, fulfilledOrders!, history!, [], 'shopSnapShot.id');

    //return ShopClass varaible shop
    return shop;
  }

  get_shop_stock(String shopName, String pin) async {
    Map<String, dynamic> stock = {};
    DocumentSnapshot data =
        await cloud.collection(shopsLocation).doc('$shopName:$pin').get();

    stock = data[skc.stock];
    DatabaseFunctionClass.shop.stock = stock;
    return stock;
  }

  Future<List<OrderClass>?> get_shop_new_orders(
      String shopName, String pin) async {
    List<OrderClass> newOrders = [];
    print(shopName);
    var values = await getDocuments('Shops', shopName, pin, 'new_orders');
    List val = [];
    for (var element in values) {
      val.add(element.data());
    }
    // print(val[0][skc.member]);

    for (var orderMap in val) {
      //Converting Medicine List to Map//////
      List<dynamic> testList = orderMap[skc.medicines];
      // print(testList);

      Map<int, dynamic> tmap = testList.asMap();
      Map<String, dynamic> nmap = {};
      for (var i = 0; i < tmap.length; i++) {
        nmap.addAll({tmap[i][skc.medicineName]: tmap[i][skc.medicineNumber]});
      }

      OrderClass _order = OrderClass(
          orderMap[skc.recipient],
          orderMap[skc.phone],
          nmap,
          orderMap[skc.total].toString(),
          'orderMap.id',
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

//////New Listener to get Pending Orders
    cloud
        .collection(shopsLocation)
        .doc('$shopName:$pin')
        .collection('pending_orders')
        .snapshots()
        .listen((event) {
      for (DocumentSnapshot order in event.docs) {
        //Converting Medicine List to Map//////
        List<dynamic> testList = order[skc.medicines];

        Map<int, dynamic> tmap = testList.asMap();
        Map<String, dynamic> nmap = {};
        for (var i = 0; i < tmap.length; i++) {
          nmap.addAll({tmap[i][skc.medicineName]: tmap[i][skc.medicineNumber]});
        }
        //End of Conversion//////////////
        //Creating a variable to store current iterated order
        OrderClass _order = OrderClass(order[skc.recipient], order[skc.phone],
            nmap, order[skc.total].toString(), order.id, order[skc.member]);

        //First Checking to see if Pending Order has already been loaded
        if (DatabaseFunctionClass.shop.shop_pending_orders.contains(_order)) {
          //Saving the orders to pending Orders
        } else {
          pendingOrders.add(_order);
        }
      }
    });

    return pendingOrders;
  }

  Future<List<OrderClass>?> get_shop_fulfilled_orders(
      String shopName, String pin) async {
    List<OrderClass> fulfilledOrders = [];
    try {
      cloud
          .collection(shopsLocation)
          .doc('$shopName:$pin')
          .collection('fulfilled_orders')
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
          fulfilledOrders.add(_order);
        }
      });
    } catch (e) {
      print('No Fulfilled Orders');
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
    print('Member Snapshot is:${memberSnapshot}');
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
      'Medicines': order.orders,
      'Total': order.total
    };

    DocumentReference id = await cloud
        .collection(shopsLocation)
        .doc('$shopName:$pin')
        .collection('new_orders')
        .add(orderMap);

    return id.id;
  }

  on_pend_order(OrderClass order, String shopName, String pin) async {
    //Creating Order Map variable
    Map<String, dynamic> orderMap = {
      'Recipient': order.recipientName,
      'Phone': order.recipientPhone,
      'Medicines': order.orders,
      'Total': order.total
    };

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
    //Creating Order Map variable
    Map<String, dynamic> orderMap = {
      'Recipient': order.recipientName,
      'Phone': order.recipientPhone,
      'Medicines': order.orders,
      'Total': order.total
    };

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
    ///     COMMISSIONING   Send OrderID plus   memberPhone      /////
    //////////////////////////////////////////////////////////////////

    ///Send Commission notification for each medicine in order

    cloud
        .collection('Members')
        .doc(order.memberPhone)
        .update({'commission': order.order_db_location});

    for (var medicine in order.orders.values) {
      for (int i = 0; i < medicine['Number']; i++) {
        cloud
            .collection('Members')
            .doc(order.memberPhone)
            .update({'commission': '${order.order_db_location}$i'});
      }
    }
  }

  on_fail_order(OrderClass order, String shopName, String pin) async {
    //Creating Order Map variable
    Map<String, dynamic> orderMap = {
      'Recipient': order.recipientName,
      'Phone': order.recipientPhone,
      'Medicines': order.orders,
      'Total': order.total
    };

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
        .collection('failed_orders')
        .add(orderMap);
  }

  /////////////////////////////

  on_logout() {}
}
