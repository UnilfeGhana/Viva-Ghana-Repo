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
        'Nego Tablets',
        'Nego Tablets',
        200,
        '''
Introducing our new food supplement, Nego Tablets. This innovative product provides users in natural and effective digestive aid, thereby having a potential for relief from aches and pains, helping you to live life to the fullest without the hindrance of discomfort.

Nego contains a powerful blend of natural ingredients, including garlic, combretum smeathmanni and khaya senegalensis, which have been used for centuries to alleviate pain and inflammation. These ingredients work together to target the root cause of pain, providing long-lasting relief without the side effects often associated with traditional pain medications.

In addition to its digestive aid and pain-relieving properties, Nego also supports arthritis, and overall joint health and mobility, making it an ideal choice for those looking to maintain an active lifestyle. Whether you suffer from chronic pain, exercise-related soreness, or occasional discomfort, Nego can help you find the relief you need.
Our food supplement is easy to incorporate into your daily routine – simply take two (2) tablets before meal, up to two times a day, as needed.
With regular use, you can experience the full benefits of Nego and enjoy a life free from the limitations of pain.
Say goodbye to discomfort and hello to a more vibrant, pain-free life with Nego. Try it today and experience the difference for yourself.

Price: 200.0 GHC
''',
        'images/Nego.jpg',
        ['Chronic pain relief', 'Inflammation', 'Soreness / Discomfort'],
        'composition',
        'instruction'),

    ProductClass(
      'Viva Lady',
      'Viva Lady',
      150,
      //Description
      '''
      It has been observed that majority of the ladies we have interacted with:

      1) Prefer flattening of their stomach

      2) Dislike fibroids

      3) Dislike Menstrual pains

      4) Dislike scanty menstrual flow, or absence of menstrual flow

      5) Dislike female reporductive health challenges

      6) Prefer natural ways of resolving health challenges

      VivaLady tablets, a totally natural food supplement, has been carefully produced under very good manufacturing practices
      for the benefits of ladies who use the product.
      VivaLady tablets is recommended for usage by females older than 11 years, except pregnant women and lactating mothers.

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
