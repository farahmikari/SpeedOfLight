import 'package:delivery_app/constants.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/models/user_info_model.dart';
import 'package:delivery_app/providers/userinfo_provider.dart';
import 'package:delivery_app/screens/home_screen/widgets/navigator_bar.dart';
import 'package:delivery_app/screens/login/login_screen.dart';
import 'package:delivery_app/screens/register/widgets/dropdown.dart';
import 'package:delivery_app/screens/register/widgets/register_button.dart';
import 'package:delivery_app/screens/register/widgets/register_info_widget.dart';
import 'package:delivery_app/services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

String? country;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static String id = "Register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? firstName, lastName, city, password, passwordConf;

  dynamic phoneNumber;

  bool isLouding = false, obscureText = true, obscureTextCon = true;

  // GlobalKey<FormState> formState = GlobalKey();

  UserInfoModel? userInfo;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isLouding,
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: DrawClip(),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.6,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              kPrimaryColor,
                              Color(0xFFE57481),
                              Color(0xFFEFB8B8)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          color: kPrimaryColor),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: size.height * 0.1, left: 16),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Do you have an account ? '),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginScreen.id);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(color: kSecondaryColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RegisterInfoWidget(
                        hintText: 'First Name',
                        icon: const Icon(Icons.person),
                        onChanged: (data) {
                          firstName = data;
                        },
                      ),
                      RegisterInfoWidget(
                        hintText: 'Last Name',
                        icon: const Icon(Icons.person),
                        onChanged: (data) {
                          lastName = data;
                        },
                      ),
                      RegisterInfoWidget(
                        hintText: 'Phone Number',
                        icon: const Icon(Icons.phone),
                        onChanged: (data) {
                          phoneNumber = data;
                        },
                        minimum: 10,
                        errorText: ' phone number is less than 10 number',
                      ),

                      const DropDownCountry(),
                      RegisterInfoWidget(
                        hintText: 'City',
                        icon: const Icon(Icons.location_on),
                        onChanged: (data) {
                          city = data;
                        },
                      ),
                      RegisterInfoWidget(
                        hintText: 'Password',
                        icon: const Icon(Icons.lock),
                        obscureText: obscureText,
                        onChanged: (data) {
                          password = data;
                          print('The password is $data');
                        },
                        minimum: 8,
                        errorText: ' passowrd is less than 8 character',
                        suffixIconEnabled: true,
                      ),

                      RegisterInfoWidget(
                          hintText: 'Confirm Password',
                          icon: const Icon(Icons.lock),
                          obscureText: true,
                          onChanged: (data) {
                            passwordConf = data;
                          },
                          minimum: 8,
                          errorText: ' passowrd is less than 8 character',
                          suffixIconEnabled: true),
                      //زر التأكيد
                      RegisterButton(
                        text: 'Register',
                        onPressed: () async {
                          isLouding = true;
                          setState(() {});
                          try {
                            await RegisterMethod(country: country);
                            print('succesful');
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                               duration: Durations.long3,
                              content: Text('register success!'),
                              backgroundColor: kPrimaryColor,
                            ));
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                 Navigatorbar.id,
                                 (route)=> false,
                                  arguments: userInfo);
                          } catch (e) {
                            print(e.toString());
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                               duration: Durations.long3,
                              content: Text('Please Try Again!'),
                              backgroundColor: Colors.red,
                            ));
                          }
                          isLouding = false;
                          setState(() {});
                        },
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> RegisterMethod({String? country}) async {
    userInfo = await RegisterService().registerService(
        firstName: firstName!,
        lastName: lastName!,
        phoneNumber: phoneNumber,
        country: country!,
        city: city!,
        password: password!,
        passwordConf: passwordConf!);
    storage.setString("id", userInfo!.user!.id.toString());
    storage.setString("token", userInfo!.token.toString());
    Provider.of<UserinfoProvider>(context,listen: false).userInfoModel = userInfo;
    isLouding = false;
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 2);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
