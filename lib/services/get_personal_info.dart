import 'package:delivery_app/helper/api.dart';
import 'package:delivery_app/models/user_info_model.dart';

class GetPersonalInfo {
  Future<UserModel> getPersonalInfo({required String token}) async {
    Map<String, dynamic> data = await Api().get(
      url: '/user',
      token: token,
    );
    return UserModel.fromJson(data);
  }
}
