import 'package:delivery_app/helper/api.dart';
import 'package:delivery_app/models/product.dart';

class GetOrders {
  Future<List<Product>> getOrder({required String token}) async {
    List<dynamic> data = await Api().get(
      url: '/Purchases/user',
      token: token,
    );
    List<Product> orders = [];
    for (int i = 0; i < data.length; i++) {
      orders.add(
        Product.fromJson(data[i]),
      );
    }
    return orders;
  }
}
