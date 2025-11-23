import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/models/user_info_model.dart';
import 'package:delivery_app/providers/userinfo_provider.dart';
import 'package:delivery_app/screens/home_screen/widgets/navigatorBar.dart';
import 'package:delivery_app/screens/info_personal/info_personal_screen.dart';
import 'package:delivery_app/screens/register/widgets/register_button.dart';
import 'package:delivery_app/screens/register/widgets/register_info_widget.dart';
import 'package:delivery_app/screens/home_screen/home_screen.dart';
import 'package:delivery_app/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String id = "Login";
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formState = GlobalKey();
  bool isLouding = false, obscureText = true;
  String? password;
  UserInfoModel? userInfo;
  dynamic phoneNumber;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isLouding,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kPrimaryColor,
                  const Color(0xFFE57481),
                  const Color(0xFFEFB8B8)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: DrawClip(),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.6,
                        decoration: BoxDecoration(color: kSecondaryColor),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: size.height * 0.1, left: 16),
                          child: Text(
                            'Welcome !',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 32,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Do you want to create an account ? '),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RegisterInfoWidget(
                          hintText: 'Phone Number',
                          icon: Icon(Icons.phone),
                          onChanged: (data) {
                            phoneNumber = data;
                          },
                          minimum: 10,
                          errorText: ' phone number is less than 10 number',
                        ),
                        RegisterInfoWidget(
                            hintText: 'Password',
                            icon: Icon(Icons.lock),
                            obscureText: true,
                            onChanged: (data) {
                              password = data;
                            },
                            minimum: 8,
                            errorText: ' passowrd is less than 8 character',
                            suffixIconEnabled: true),
                        RegisterButton(
                          text: 'Login',
                          onPressed: () async {
                            isLouding = true;
                            setState(() {});

                            try {
                              await LoginMethod();

                              print('succesful');

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                duration: Durations.long3,
                                content: Text('Login success!'),
                                backgroundColor: kPrimaryColor,
                              ));
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Navigatorbar.id, (route) => false,
                                  arguments: userInfo);
                            } catch (e) {
                              print(e.toString());
                              AwesomeDialog(
                                
                                  context: context,
                                  title: "Alert",
                                  body: Text(
                                      "your number is uncorrect or your password"))
                                ..show();
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
      ),
    );
  }

  Future<void> LoginMethod() async {
    userInfo = await LoginService().loginService(
      phoneNumber: phoneNumber,
      password: password!,
    );
    storage.setString("id", userInfo!.user!.id.toString());
    storage.setString("token", userInfo!.token.toString());
    isLouding = false;
    Provider.of<UserinfoProvider>(context, listen: false).userInfoModel =
        userInfo;
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
