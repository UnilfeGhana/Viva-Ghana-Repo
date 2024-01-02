import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vr_plate/Class/Local/ProductClass.dart';
import 'package:vr_plate/Class/environment.dart';
import 'package:vr_plate/Functions/ClassFunctions/ShopFunctions.dart';
import 'package:vr_plate/Functions/ServerFunctions/ServerFunctions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Shop {
  ShopFunctions shopFunctions = ShopFunctions();
  final ServerFunctions _serverFunctions = ServerFunctions();
  final FirebaseFirestore cloud = FirebaseFirestore.instance;
  static List<Marker> shopMarkers = [];

  //Change: Shop class shouldn't accessed directly but rather through
  // ShopFunctions class

  Shop() {
    if (DevEnv.environment == 'local') {
      return;
    } else {
      products = _serverFunctions.sGetProducts();
      carousel = _serverFunctions.sGetCarousel();
    }
  }

  static List<ProductClass> products = [
    //Viva Lady
    //Viva Plus 120-70
    //Viva Plus 90-60
    ProductClass(
      'Viva Lady',
      'Viva Lady',
      150,
      //Description
      '''
      Viva Lady is a general well-being food supplement for Women.

      Viva Lady Tablets contains herbal products that aid in Weight Loss, and flattening the Stomach.

      *visible results within one month.
      (Recommended for females 12 years and above except pregnant women and lactating mothers)

      Price: 150.00 GHC
''',
      // 'Viva Lady is a complete well-being nutritional formula for the Lady. \n\n\n .',
      'images/VivaLadyTablet.png',
      ['Ladies Companion'],
      'composition',
      'instruction',
    ),
//     ProductClass(
//       'Viva Plus\n(120)',
//       'Viva Plus\n(120)',
//       100,
//       //Description
//       '''
// Detoxification, is beneficial in cleansing the blood vessels leading to Cardiovascular wellbeing

// Good Blood Circulation is essential for maintaining overall health and well-being in humans by:
//       -Delivering oxygen-rich blood to all organs and tissues.
//       -Maintenance of organ functions
//       -Improve immune response

//       (Recommended for 12 years and above,except pregnant women and lactating mothers).
//          ''',
//       'images/120tabsViva.png',
//       ['Detoxification', 'Blood Circulation'],
//       'composition',
//       'instruction',
//     ),

    ProductClass(
      'Viva Plus\n(90)',
      'Viva Plus\n(90)',
      80,
      //Description
      '''
Detoxification is beneficial in cleansing the blood vessels leading to Cardiovascular wellbeing

Good Blood Circulation is essential for maintaining overall health and well-being in humans by:
      -Delivering oxygen-rich blood to all organs and tissues. 
      -Maintenance of organ functions 
      -Improve immune response 
         
      (Recommended for 12 years and above,except pregnant women and lactating mothers).

      Price: 80.00 GHC
         ''',
      'images/90tabsViva.png',
      ['Detoxification', 'Blood Circulation'],
      'composition',
      'instruction',
    ),
    //Commented out the smallest viva tablet bottle
    // ProductClass(
    //   'Viva Plus (60)',
    //   'Viva Plus (60)',
    //   50,
    //   //Description
    //   'Good Blood Circulation is essential for maintaining overall health and well-being in humans by:\n -Delivering oxygen-rich blood to all organs and tissues. \n -Maintenance of otrgan functions \n -Improve immune response \n\n(Recommended for 12 years and above,except pregnant women and lactating mothers).',
    //   'images/VivaPlus60.jpg',
    //   ['Immune Booster', 'Improves Digestion', 'Detoxification'],
    //   'composition',
    //   'instruction',
    // ),
  ];
  static List<CarouselClass> carousel = [
    CarouselClass(
        'Earn Cash',
        'Add your Friends and Family to earn real Cash Monthly',
        'images/bermix-studio-NQf1efWvh5k-unsplash.jpg',
        'MemberScreen'),
    CarouselClass('Flat Tummy', 'Learn to lose weight naturally',
        'images/(B-pink standing)julia-rekamie.jpg', 'link'),
    CarouselClass('Good Diet', 'Learn to eat to stay healthy',
        'images/(Carousel-HealthyFood).jpg', 'VivaLadyScreen'),
    // CarouselClass('Delivery Services', 'About our delivery Services',
    //     'images/rowan-freeman-clYlmCaQbzY-unsplash.jpg'),
    CarouselClass(
        'Customer Care',
        'Issue a complaint or get all your questions answered right here',
        'images/(CarouselCustomerCare).jpg',
        'link'),
  ];
}
