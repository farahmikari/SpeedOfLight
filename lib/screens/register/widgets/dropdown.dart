import 'package:delivery_app/constants.dart';
import 'package:delivery_app/screens/register/register_screen.dart';
import 'package:flutter/material.dart';

class DropDownCountry extends StatefulWidget {
  const DropDownCountry({super.key});

  @override
  State<DropDownCountry> createState() => _DropDownCountryState();
}

class _DropDownCountryState extends State<DropDownCountry> {
  static String dropDownCountry = "select country";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Container(
        padding: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black),
          color: Colors.white,
        ),
        child: DropdownButton<String>(
            value: dropDownCountry,
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              color: kPrimaryColor,
            ),
            elevation: 16,
            style: TextStyle(
                color: Colors.grey, fontFamily: "PatuaOne", fontSize: 18),
            items: const [
              DropdownMenuItem(
                child: Text(
                  "select country",
                ),
                value: "select country",
              ),
              DropdownMenuItem(
                child: Text("Damascus",style: TextStyle(color: Colors.black),),
                value: "Damascus",
              ),
              DropdownMenuItem(
                child: Text("Damascus Countryside",style: TextStyle(color: Colors.black),),
                value: "Damascus Countryside",
              )
            ],
            isExpanded: true,
            underline: SizedBox.shrink(),
            iconSize: 40,
            onChanged: (String? countrySelected) {
              if (countrySelected != null &&
                  countrySelected != "select country") {
                setState(() {
                  dropDownCountry = countrySelected;
                  country = dropDownCountry;
                });
              }
            }),
      ),
    );
  }
}
