import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vr_plate/Class/Local/Shop.dart';
import 'package:vr_plate/Class/Local/VendorClass.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class LocationClass {
  bool locationEnabled = false;
  static late Position position;
  static late LocationPermission permission;
  static bool locationGranted = false;
  static String closestShop = 'Head Office:0003';
  static String selectedShop = '';

//Dependency Function for Marker Icon
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

//Function to show path for marker Icon
  markerIcon() async {
    final Uint8List markerIcon = await getBytesFromAsset(
        'assets/images/free-store-icon-2017-thumb.png', 100);
    return markerIcon;
  }

  getDeviceLocation() async {
    locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (await _handlePermissions()) {
      // return true;

      if (locationEnabled) {
        if ((await Geolocator.getLastKnownPosition()) != null) {
          position = (await Geolocator.getLastKnownPosition())!;
        } else {
          position = await Geolocator.getCurrentPosition();
        }
      }
    } else {
      await Geolocator.openLocationSettings();
    }
    return position;
  }

  Future<bool> _handlePermissions() async {
    permission = await Geolocator.checkPermission();
    //Location can't be accessed with first 2 conditions
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      return false;
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }
    getClosestShop();
    return true;
  }

  ///Functions used to Calculate nearest Vendor's Shop
  getClosestShop() {
    CollectionReference shopRef =
        FirebaseFirestore.instance.collection('Shops');

    double currentDistance = 99999999999999, distanceBuffer;
    Vendors closestShop = Vendors('shopName', 'shopPhone', 0, 0, 0);
    Vendors selectedShop = Vendors('shopName', 'shopPhone', 0, 0, 0);
    Vendors shopBuffer = Vendors('shopName', 'shopPhone', 0, 0, 0);
    GeoPoint geopoint;

    //Get all the Shop Names
    shopRef.snapshots().listen((data) {
      for (var item in data.docs) {
        geopoint = item['location'];

        shopBuffer.lat = geopoint.latitude;
        shopBuffer.long = geopoint.longitude;
        shopBuffer.vendorName = item['shop Name'].toString().split(":")[0];
        shopBuffer.vendorPhone = item['shop Phone'].toString().split(":")[0];
        //Adding All Shops to Map so that the user can see nearby shops
        Shop.shopMarkers.add(Marker(
          infoWindow: InfoWindow(
              title: item['shop Name'].toString().split(":")[0],
              snippet: item['shop Phone'].toString().split(":")[0]),
          markerId: item['shop Name'],
          position: LatLng(geopoint.latitude, geopoint.longitude),
          icon: BitmapDescriptor.fromBytes(markerIcon()),
        ));

        distanceBuffer = Geolocator.distanceBetween(position.latitude,
            position.longitude, shopBuffer.lat, shopBuffer.long);

        if (distanceBuffer < currentDistance) {
          currentDistance = distanceBuffer;
          closestShop.vendorName = shopBuffer.vendorName;
          closestShop.distance = currentDistance;
          closestShop = shopBuffer;
          selectedShop = closestShop;
        }
      }
      print('the Closest shop was ${closestShop}');
    });
  }
}
