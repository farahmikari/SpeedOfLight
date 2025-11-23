import 'package:delivery_app/helper/api.dart';
import 'package:delivery_app/models/user_info_model.dart';

class LoginService {

Future<UserInfoModel> loginService(
      {
      required dynamic phoneNumber,
   
      required String password,
      }) async {
    Map<String, dynamic> data =
        await Api().post(url: '/login', body: {
      
      'phone_number': phoneNumber,
      
      'password': password,
      
    });
    print(data);
    return UserInfoModel.fromJson(data);
  }




}