import 'package:delivery_app/constants.dart';
import 'package:flutter/material.dart';

class RegisterInfoWidget extends StatefulWidget {
  RegisterInfoWidget(
      {required this.hintText,
      required this.icon,
      this.onChanged,
      this.obscureText = false,
      this.minimum = 0,
      this.errorText,
      this.suffixIconEnabled=false});

  final String hintText;
  final Icon icon;
  
  final Function(String)? onChanged;
  final bool? obscureText;
  final int? minimum;
  final String? errorText;
  final bool suffixIconEnabled;
  @override
  State<RegisterInfoWidget> createState() => _RegisterInfoWidgetState();
}

class _RegisterInfoWidgetState extends State<RegisterInfoWidget> {
  final GlobalKey<FormState> formState = GlobalKey();
  late bool _isObscured;
  final TextEditingController _passoword = TextEditingController();

  void initState() {
    super.initState();
    _isObscured = widget.obscureText!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Form(
        key: formState,
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          child: TextFormField(
            controller: _passoword,
            validator: (data) {
              if (data!.isEmpty) {
                return ' field is required';
              }
              if (data.length < widget.minimum!) {
                return widget.errorText;
              }
            },
            
            onChanged: widget.onChanged,
            obscureText: widget.suffixIconEnabled?_isObscured:false,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.grey),
              hintText: widget.hintText,
              prefixIcon: widget.icon,
              prefixIconColor: kPrimaryColor,
              suffixIcon: widget.suffixIconEnabled?
              IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            icon: Icon(_isObscured
                                ? Icons.visibility_off
                                : Icons.visibility)):null,
                      
              
              border: InputBorder.none,
              errorStyle: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
