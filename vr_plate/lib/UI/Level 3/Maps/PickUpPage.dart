import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vr_plate/Class/Local/Shop.dart';
import 'package:vr_plate/Functions/ClassFunctions/LocationClass.dart';
import 'package:vr_plate/Functions/EventHandler/Level_3_events.dart';
import 'package:vr_plate/UI/Level%203/Maps/OrderSummaryCards.dart';

import '../../../Functions/ClassFunctions/UserFunctions.dart';

class PickUpLocationPage extends StatefulWidget {
  const PickUpLocationPage({Key? key}) : super(key: key);

  @override
  State<PickUpLocationPage> createState() => _PickUpLocationPageState();
}

class _PickUpLocationPageState extends State<PickUpLocationPage> {
  String username = '', phoneNumber = '';
  LocationClass location = LocationClass();
  late GoogleMapController mapController;
  late BitmapDescriptor myIcon;
  String selectedShop = LocationClass.closestShop.split(':')[0];

  @override
  Widget build(BuildContext context) {
    L3EventHandler eventH = L3EventHandler(context);
    Set<Marker> allMarkers = Shop.shopMarkers.toSet();

    Marker marker = Marker(
        // icon: myIcon,
        infoWindow: const InfoWindow(title: 'Move the Pin to your location'),
        markerId: const MarkerId('value'),
        position: LatLng(
            LocationClass.position.latitude, LocationClass.position.longitude));
    allMarkers.add(marker);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pin Location'),
          backgroundColor: Colors.white,
          toolbarHeight: 100,
        ),
        body: Stack(
          children: [
            Container(
                height: 600, // MediaQuery.of(context).size.height * 0.59,
                width: 500,
                color: Colors.yellow,
                //for google maps
                child: GoogleMap(
                    myLocationButtonEnabled: true,
                    // onMapCreated: (controller) {
                    //   mapController = controller;
                    // },
                    onCameraMove: (newPosition) {
                      setState(() {
                        // marker.position.latitude = Position
                        LocationClass.position = Position(
                            longitude: newPosition.target.longitude,
                            latitude: newPosition.target.latitude,
                            timestamp: LocationClass.position.timestamp,
                            accuracy: LocationClass.position.accuracy,
                            altitude: LocationClass.position.altitude,
                            heading: LocationClass.position.heading,
                            speed: LocationClass.position.speed,
                            speedAccuracy:
                                LocationClass.position.speedAccuracy);
                      });
                    },
                    // markers: {marker},
                    markers: allMarkers,
                    initialCameraPosition: CameraPosition(
                        zoom: 17,
                        // tilt: 40,
                        target:
                            // LatLng(25,50),
                            LatLng(LocationClass.position.latitude,
                                LocationClass.position.longitude)))),
            DraggableScrollableSheet(
                minChildSize: 0.31,
                initialChildSize: 0.4,
                maxChildSize: 0.8,
                builder: (BuildContext context, ScrollController controller) {
                  return SingleChildScrollView(
                    controller: controller,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          // border: Border(left: BorderSide(color: Colors.red)),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      // height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                        const SizedBox(height: 10),
                        const Text('Please Scroll to Enter your Details',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 50),
                        SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Name:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 15),
                              Container(
                                width: 250,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      username = value;
                                    });
                                  },
                                  // decoration: const InputDecoration(
                                  //   border: OutlineInputBorder(
                                  //       borderRadius:
                                  //           BorderRadius.all(Radius.zero)),
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          child: Row(
                            textBaseline: TextBaseline.ideographic,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              const Text('Phone:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 15),
                              Container(
                                width: 250,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      phoneNumber = value;
                                    });
                                  },
                                  // decoration: InputDecoration(
                                  //   border: OutlineInputBorder(borderSide: BorderSide.none),
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          'Above location would be used during delivery by Vendor:\n${selectedShop}',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Order Summary',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        OrderSummary(
                          controller: controller,
                        ),
                        const SizedBox(height: 10),
                        Text('Total: ${UserFunction.total}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              eventH.placeOrder(username, phoneNumber);
                            },
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: const Text('Confirm Order')))
                      ]),
                    ),
                  );
                }),
          ],
        ));
  }
}
