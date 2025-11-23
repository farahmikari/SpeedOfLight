

import 'package:delivery_app/helper/api.dart';


class AddOrderService {
  Future<bool> addOrder({required dynamic body, required String token}) async {
     dynamic response =
          await Api().post(url: '/Purchases/store', body: body,
           token: token,
           header: {'Content-Type': 'application/json'});
      print(response);

    

    return true;
  }
}
