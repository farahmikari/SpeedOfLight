import 'package:delivery_app/helper/api.dart';
import 'package:delivery_app/main.dart';

class LogoutService {
  Future<bool> logoutService({required String token}) async {
    Map<String, dynamic> data = await Api().post(url: '/logout', token: token);
    storage.clear();
    print("yes");
    return true;
  }
}
