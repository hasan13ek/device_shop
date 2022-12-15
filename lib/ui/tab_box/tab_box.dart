import 'package:device_shop/data/models/user_model.dart';
import 'package:device_shop/ui/tab_box/card/card_page.dart';
import 'package:device_shop/ui/tab_box/hom_page/home_page.dart';
import 'package:device_shop/ui/tab_box/profile_page/profile_page.dart';
import 'package:device_shop/view_models/profile_view_model.dart';
import 'package:device_shop/view_models/tab_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens.add(HomePage());
    screens.add(CardPage());
    screens.add(ProfilePage());
    _printFCMToken();
    super.initState();
  }
  _printFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (!mounted) return;
    UserModel? userModel =
        Provider.of<ProfileViewModel>(context, listen: false).userModel;
    if (userModel != null) {
      Provider.of<ProfileViewModel>(context, listen: false)
          .updateFCMToken(token ?? "", userModel.userId);
    }

    print("FCM TOKEN:$token");
  }

  @override
  Widget build(BuildContext context) {
    var index = context.watch<TabViewModel>().activePageIndex;
    return Scaffold(
      backgroundColor: Colors.black,
      body: screens[index],
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.grey.withOpacity(0.4),
        selectedBackgroundColor: Colors.black.withOpacity(0.4),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        borderRadius: 15,
        onTap: (value) => Provider.of<TabViewModel>(context, listen: false)
            .changePageIndex(value),
        items: [
          FloatingNavbarItem(
              customWidget: Icon(
                Icons.home,
                color: index == 0 ? Colors.white : Colors.grey,
              ),
              title: 'Home'),
          FloatingNavbarItem(
              customWidget: Icon(
                Icons.shopping_cart_outlined,
                color: index == 1 ? Colors.white : Colors.grey,
              ),
              title: 'Cart'),
          FloatingNavbarItem(
              customWidget: Icon(
                Icons.perm_identity_outlined,
                color: index == 2 ? Colors.white : Colors.grey,
              ),
              title: 'Profile')
        ],
        currentIndex: index,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (value) => Provider.of<TabViewModel>(context, listen: false)
      //       .changePageIndex(value),
      //   items:const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
      //   ],
      // ),
    );
  }
}
