import 'package:delivery_app/providers/add_to_cart_provider.dart';
import 'package:delivery_app/providers/favorite_provider.dart';
import 'package:delivery_app/providers/product_details_provider.dart';
import 'package:delivery_app/providers/products_provider.dart';
import 'package:delivery_app/providers/stores_provider.dart';
import 'package:delivery_app/providers/userinfo_provider.dart';
import 'package:delivery_app/screens/cart_screen/cart_screen.dart';
import 'package:delivery_app/screens/favorite_screen/favorite_screen.dart';
import 'package:delivery_app/screens/history_order_screen/orders_screen.dart';
import 'package:delivery_app/screens/home_screen/widgets/navigator_bar.dart';
import 'package:delivery_app/screens/info_personal/info_personal_screen.dart';
import 'package:delivery_app/screens/login/login_screen.dart';
import 'package:delivery_app/screens/register/register_screen.dart';
import 'package:delivery_app/screens/splash_screen/splach_screen.dart';
import 'package:delivery_app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences storage;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  storage = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AddToCartProvider()),
        ChangeNotifierProvider(create: (context) => ProductDetailsProvider()),
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => StoresProvider()),
        ChangeNotifierProvider(create: (context) => UserinfoProvider(),),
        ChangeNotifierProvider(create: (context) => FavoriteProvider(),),

      ],
    child: DeliveryApp(),
  ));
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplachScreen(),
      theme: ThemeData(fontFamily: 'PatuaOne'),
      routes: {
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        InfoPersonalScreen.id: (context) => InfoPersonalScreen(),
        CartScreen.id:(context)=>CartScreen(),
        HomeScreen.id:(context)=>HomeScreen(),
        Navigatorbar.id:(context)=>Navigatorbar(),
        OrdersScreen.id:(context)=>OrdersScreen(),
        FavoriteScreen.id:(context)=>FavoriteScreen()
       
      },
      
    );
  }
}
