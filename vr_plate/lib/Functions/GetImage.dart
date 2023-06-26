import 'package:flutter/cupertino.dart';
import 'package:vr_plate/Class/Environment.dart';

class GetImage {
  List<String> images = [
    'images/(B-pink standing)julia-rekamie.jpg',
    'images/(Carousel-HealthyFood).jpg',
    'images/rowan-freeman-clYlmCaQbzY-unsplash.jpg',
    'images/VivaLadyTablet.jpg',
    'images/VivaPlusTablet.jpg',
    'images/VivaBackground.jpg',
    'images/illustrstion_Deliver.png',
    'images/undraw_medicine_b1ol.png',
  ];

  AssetImage getLocalImage(int index) {
    return AssetImage(images[index]);
  }

  AssetImage getNameLocalImage(String name) {
    return AssetImage(name);
  }

  getImage(int index) {
    if (DevEnv.environment == 'local') {
      return AssetImage(images[1]);
    } else if (DevEnv.environment == 'serverTest') {
      return NetworkImage('url');
    }
  }

  getNamedImage(String img) {
    if (DevEnv.environment == 'local') {
      return AssetImage(img);
    } else if (DevEnv.environment == 'serverTest') {
      return NetworkImage(img);
    }
  }
}
