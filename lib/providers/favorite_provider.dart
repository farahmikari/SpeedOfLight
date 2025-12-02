import 'package:delivery_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Product> _favProduct = [];
  List<Product> get favProduct => _favProduct;
  Set<String> _favProductID = {};

  set favProduct(List<Product> fav) {
    _favProduct = fav;
    for (Product product in _favProduct) {
      _favProductID.add(product.id.toString());
    }
    notifyListeners();
  }

  set favProductID(Set<String> favID) {
    _favProductID = favID;
    notifyListeners();
  }


  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
