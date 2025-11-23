import 'dart:io';

import 'package:delivery_app/constants.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/models/user_info_model.dart';
import 'package:delivery_app/providers/userinfo_provider.dart';
import 'package:delivery_app/services/add_image_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageProfile extends StatefulWidget {
  ImageProfile({this.imageFromUser});

  dynamic imageFromUser;
  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  File? image;

  //Image.file(image!, width: 100, fit: BoxFit.cover).image
  @override
  Widget build(BuildContext context) {
    UserInfoModel? userInfoModel =
        Provider.of<UserinfoProvider>(context).userInfoModel;

    Future<void> _pickImageFromGallery() async {
      final pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      setState(() {
        try {
          if (pickedFile != null) {
            image = File(pickedFile.path);

            print("The path" + pickedFile.path);
          }
        } catch (e) {
          print("Exception" + e.toString());
        }
      });

      try {
        bool status = await AddImageService()
            .addImage(token: storage.getString("token")!, image: image!);
        print('the image path file $image , ${storage.getString("token")!}');
        if (status) {
          print('true in image profile');
        } else {
          print('false in image profile');
        }
      } catch (e) {
        print("don't add any image");
      }
    }

    return GestureDetector(
        onTap: _pickImageFromGallery,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(75),border: Border.all(color: Colors.black)),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: Icon(
                Icons.person,
                size: 70,
                color: kPrimaryColor,
              ),
              foregroundImage:
                  (widget.imageFromUser == null) && (image == null)
                      ? null
                      : image != null
                          ? Image.file(image!, width: 100, fit: BoxFit.cover)
                              .image
                          : Image.network(widget.imageFromUser).image),
        ));
  }
}
