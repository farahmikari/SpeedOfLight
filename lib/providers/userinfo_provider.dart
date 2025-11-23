import 'package:delivery_app/models/user_info_model.dart';
import 'package:flutter/material.dart';

class UserinfoProvider extends ChangeNotifier {
  UserInfoModel? _userInfoModel;
  set userInfoModel(UserInfoModel? user) {
    _userInfoModel = user;
    notifyListeners();
  }

  UserInfoModel? get userInfoModel => _userInfoModel;
}
