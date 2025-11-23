import 'package:delivery_app/constants.dart';
import 'package:delivery_app/services/register_service.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  RegisterButton({super.key, this.onPressed,this.text});
  VoidCallback? onPressed;
  String? text;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: EdgeInsets.all(16),
            height: 50,
            width: 200,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: kPrimaryColor.withOpacity(0.6),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: Offset(0, 2))
            ], color: kPrimaryColor, borderRadius: BorderRadius.circular(30)),
            child: MaterialButton(
              onPressed: onPressed
           
              ,
              child: Text(
                text!,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            )));
  }
}
