import 'package:delivery_app/helper/api.dart';
import 'package:delivery_app/models/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterService {

  Future<UserInfoModel> registerService(
      {required String firstName,
      required String lastName,
      required dynamic phoneNumber,
      required String country,
      required String city,
      required String password,
      required String passwordConf}) async {
    Map<String, dynamic> data =
        await Api().post(url: '/register', body: {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'country': country,
      'city': city,
      'password': password,
      'password_confirmation': password,
    });
    print(data);
    return UserInfoModel.fromJson(data);
  }
}
