import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/screens/cart_screen/cart_screen.dart';
import 'package:delivery_app/screens/favorite_screen/favorite_screen.dart';
import 'package:delivery_app/screens/history_order_screen/orders_screen.dart';
import 'package:delivery_app/screens/home_screen/home_screen.dart';
import 'package:delivery_app/screens/info_personal/info_personal_screen.dart';
import 'package:delivery_app/screens/login/login_screen.dart';
import 'package:delivery_app/services/logout_service.dart';
import 'package:flutter/material.dart';

class Navigatorbar extends StatefulWidget {
  const Navigatorbar({super.key});
  static String id = "navigation";
  @override
  State<Navigatorbar> createState() => _NavigatorbarState();
}

class _NavigatorbarState extends State<Navigatorbar> {
  int selectedIndex = 1;
  List<Widget> pages = [
    InfoPersonalScreen(),
    HomeScreen(),
    CartScreen(),
    OrdersScreen(),
    FavoriteScreen()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: selectedIndex == 1
          ? AppBar(
              title: const Text(
                'Home Page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              backgroundColor: kPrimaryColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      print("here");
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.topSlide,
                        title: "Alert",
                        body: const Text("Are you sure you want to logout?"),
                        btnOkIcon: Icons.check,
                        btnOkOnPress: () async {
                          bool status = await LogoutService().logoutService(
                              token: storage.getString("token")!);
                          if (status) {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginScreen.id,
                                (Route<dynamic> route) => false);
                          }
                        },
                        btnOkColor: Colors.green,
                        showCloseIcon: true,
                      ).show();
                    },
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          : selectedIndex == 2
              ? AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: kPrimaryColor,
                  centerTitle: true,
                  title: const Text(
                    "M Y  C A R T",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              : null,

      // selectedIndex==3?

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        currentIndex: selectedIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        iconSize: 23,
        selectedFontSize: 18,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'profile'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: 'cart'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.inventory,
              ),
              label: 'orders'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'favorite'),
        ],
      ),
    );
  }
}
