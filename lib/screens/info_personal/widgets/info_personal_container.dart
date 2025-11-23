import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';

class InfoPersonalContainer extends StatelessWidget {
  InfoPersonalContainer({required this.text,required this.icon});

  String text;
  dynamic icon;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          width: size.width,
          height: 55,
          child: Row(
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text( text,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.5),
        )
      ],
    );
  }
}
