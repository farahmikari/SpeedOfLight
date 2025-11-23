import 'package:delivery_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartProvider extends ChangeNotifier {
  List<Product> _cart = [];
  List<Product> get cart => _cart;
  set cart(List<Product> cart) {
    _cart = cart;
    notifyListeners();
  }

  void toogleFavorite(Product product) {
    if (_cart.contains(product)) {
      for (Product element in _cart) {
        element.quantityToSend++;
      }
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }

  increamnt(int index) {
    _cart[index].quantityToSend++;
    notifyListeners();
  }

  decreamnt(int index) {
    if (_cart[index].quantityToSend <= 1) {
      print("here");
      return;
    }
    _cart[index].quantityToSend--;
    notifyListeners();
  }

  totalPrice() {
    double myTotal = 0.0;
    for (Product element in _cart) {
      String priceEdit = element.price!.trim().replaceAll(".", "");
      double price = double.parse(priceEdit.trim().replaceAll("\$", ""));
      myTotal += price * element.quantityToSend;
    }

    return myTotal;
  }

  static AddToCartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<AddToCartProvider>(
      context,
      listen: listen,
    );
  }
}
