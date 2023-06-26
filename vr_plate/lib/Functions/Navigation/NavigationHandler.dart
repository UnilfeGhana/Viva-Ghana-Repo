import 'package:flutter/material.dart';
import 'package:vr_plate/Class/Local/Shop.dart';
import 'package:vr_plate/UI/Level 1/L1screenExport.dart';
import 'package:vr_plate/UI/Level%201/OTPpage.dart';
import 'package:vr_plate/UI/Level%202/Cart/CartPage.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePage.dart';
import 'package:vr_plate/UI/Level%202/HomePage/HomePageViews/NewMemberView.dart';
import 'package:vr_plate/UI/Level%203/AmountInputPage.dart';
import 'package:vr_plate/UI/Level%203/Carousel/CarouselDetailPage.dart';
import 'package:vr_plate/UI/Level%203/Maps/PickUpPage.dart';
import 'package:vr_plate/UI/Level%203/Product/ProductPage.dart';
import 'package:vr_plate/UI/Level%203/Product/TestProductPage.dart';

class NavHandler {
  clearLayers(BuildContext context) {
    return Navigator.of(context).pop();
  }

  Level1Nav(String screen, BuildContext context) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      switch (screen) {
        case 'Login':
          return const LoginScreen();

        // case 'SignUp':
        //   return const SignUpScreen();
        default:
          return const LoginScreen();
      }
    }));
  }

  Level2Nav(String page, BuildContext context) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      switch (page) {
        case 'Login':
          return const LoginScreen();

        case 'HomePage':
          return const HomePage();

        case 'Cart':
          return const CartPage();

        default:
          return const HomePage();
      }
    }));
  }

  Lev3Nav(String page, BuildContext context, int? index) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      switch (page) {
        case 'openProduct':
          //change to open Product Page
          return NewProductPage(
            ProductIndex: index!,
          );

        case 'HomePage':
          return const HomePage();

        case 'openCarousel':
          return CarouselDetialPage(
            carouselIndex: index!,
          );

        case 'Cart':
          return const CartPage();

        default:
          return const HomePage();
      }
    }));
  }

  Lev4Nav(String page, BuildContext context, int? index) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      switch (page) {
        case 'HomePage':
          return const HomePage();

        case 'openProductAmount':
          return AmountInputPage(medicineIndex: index!);

        case 'openPickUpPage':
          return const PickUpLocationPage();

        case 'Cart':
          return const CartPage();

        default:
          return const HomePage();
      }
    }));
  }

  PopUpSuccess(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            content:
                const Icon(Icons.thumb_up_alt_rounded, color: Colors.green),
          );
        });
  }

  PopUpFailed(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('$text failed'),
            content: const Icon(Icons.not_interested, color: Colors.red),
          );
        });
  }

  PopUpLoading(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            content: const CircularProgressIndicator(color: Colors.green),
          );
        });
  }

  carouselLink(BuildContext context, String link) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      switch (link) {
        case 'MemberScreen':
          return const NewMemberView();
        case 'VivaLadyScreen':
          //change to open Product Page
          return NewProductPage(
            ProductIndex: Shop.carousel.indexWhere((element) {
              return element.title == 'Viva Lady';
            }),
          );
        default:
          return const HomePage();
      }
    }));
  }
}
