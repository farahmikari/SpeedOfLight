import 'package:delivery_app/helper/api.dart';
import 'package:delivery_app/models/product.dart';

class GetFavoriteProduct {
  Future<List<Product>> getFavoriteProducts({required String token}) async {
    
    List<dynamic> data = await Api().get(
      url: '/product/getFavorite',
      token: token,
    );
    List<Product> favProduct = [];
    for (int i = 0; i < data.length; i++) {
      favProduct.add(Product.fromJson(data[i]));
      
    }
    return favProduct;
  }
}
