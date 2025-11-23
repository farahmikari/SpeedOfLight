import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/screens/home_screen/widgets/navigatorBar.dart';
import 'package:delivery_app/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      backgroundColor: kPrimaryColor,
      splash: Center(
        child: Column(
          children: [
            Expanded(
              child: Lottie.asset(
                'assets/splash_screen/splash.json',
               
              ),
            ),
           
            const Text(
              "Speed Of Light",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      nextScreen:
      storage.getString("id")==null ? RegisterScreen():
       const Navigatorbar(),
      splashIconSize: size.width*0.6,

      duration: 4000,
    );
  }
}
