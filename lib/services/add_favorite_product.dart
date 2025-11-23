import 'package:delivery_app/helper/api.dart';

class AddFavoriteProduct {
  Future<bool> addFavoriteProduct(
      {required String token, required dynamic idProduct}) async {
    print(idProduct);
    
    dynamic data = await Api().post(
      url: '/product/favorite',
      body: {'product_id': idProduct.toString()},
      token: token,
    );
    
    return true;
  }
}
