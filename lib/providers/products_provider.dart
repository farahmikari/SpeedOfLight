import 'dart:collection';
import 'dart:convert';
import 'package:delivery_app/helper/api.dart';
import 'package:delivery_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  List<Product> _items = [];

  TextEditingController searchController = TextEditingController();

  UnmodifiableListView<Product> get items => UnmodifiableListView(_items);

  getProductsAsync(int storeId) async {
    var data = await Api().get(url: '/store/$storeId', token: null);

    var products = Products.fromJson(data);

    _items = products.listOfProduct ?? [];
    notifyListeners();
  }

  getTopProductsAsync() async {
    var data = await Api().get(url: '/products/top3', token: null);

    var products = Products.fromJson(data);

    _items = products.listOfProduct ?? [];
    notifyListeners();
  }

  searchForProductAsync(String name) async {
    try {
      List<dynamic> data = await Api().post(
        url: '/product/search',
        token: null,
        body: {'name': '$name'},
        header: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }
      );


List<Product> products = data.map((item) => Product.fromJson(item)).toList();

      _items = products;
      notifyListeners();
    } catch (e) {
      print("Error: $e");
       _items = List.empty();
        notifyListeners();
    }
  }

 
  
}
