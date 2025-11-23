import 'dart:collection';
import 'dart:convert';
import 'package:delivery_app/helper/api.dart';
import 'package:delivery_app/models/porduct_to_send.dart';
import 'package:delivery_app/models/stores.dart';
import 'package:flutter/material.dart';

class StoresProvider extends ChangeNotifier {
  List<Store> _items = [];
  String? message;
  TextEditingController searchController = TextEditingController();

  UnmodifiableListView<Store> get items => UnmodifiableListView(_items);

  ProductToSendList? productToSendList;
  void add(int productId, int quantity) {
    productToSendList?.products.add(ProductToSend(
        productId: productId.toString(), quantity: quantity.toString()));
  }

  void removeAll() {
    productToSendList?.products.clear();
  }

  getAllStoresAsync() async {
    var data = await Api().get(url: '/stores', token: null);

    var stores = Stores.fromJson(data);

    _items = stores.listOfStore ?? [];
    notifyListeners();
  }

  getStoresByCategoryIdAsync(int categoryId) async {
    List<dynamic> data =
        await Api().get(url: '/category/$categoryId', token: null);

    var stores = Stores.fromJson(data);

    _items = stores.listOfStore ?? [];
    notifyListeners();
  }

  searchForStoreAsync(String name) async {
    try {
      List<dynamic> data = await Api().post(
        url: '/store/search',
        token: null,
        body: {'name': name},
      );

      List<Store> stores = data.map((item) => Store.fromJson(item)).toList();

      _items = stores;
      notifyListeners();
    } catch (e) {
      print("Error: $e");

      if (e.toString().contains("No stores found")) {
        print("No stores found for the search criteria.");

        _items = List.empty();
        notifyListeners();
      } else {
        print("An error occurred while fetching the stores.");
         _items = List.empty();
        notifyListeners();
      }
    }
  }

  addPurchasesAsync() async {
    var data = await Api().post(
        url: '/Purchases/store',
        token: null,
        body: jsonEncode(productToSendList?.toJson()));

    message = data['message'] as String;

    notifyListeners();
  }
}
