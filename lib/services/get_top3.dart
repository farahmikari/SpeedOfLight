import 'package:delivery_app/helper/api.dart';
import 'package:delivery_app/models/product.dart';

class GetTop3 {
  Future<List<Product>> getTop3() async {
    List<dynamic> data = await Api().get(url: '/products/top3');
    List<Product> Top3=[];
    for (int i = 0; i < data.length; i++) {
      Top3.add(
        Product.fromJson2(data[i]),
      );
    }
    return Top3;
  }
}
