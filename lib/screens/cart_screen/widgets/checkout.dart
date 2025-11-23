import 'dart:convert';

import 'package:delivery_app/constants.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/models/porduct_to_send.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/user_info_model.dart';
import 'package:delivery_app/providers/add_to_cart_provider.dart';
import 'package:delivery_app/providers/userinfo_provider.dart';
import 'package:delivery_app/services/add_order_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = AddToCartProvider.of(context);
    UserInfoModel? userInfoModel =
        Provider.of<UserinfoProvider>(context).userInfoModel;
    return
        // initialChildSize: 0.2,
        // minChildSize: 0.1,
        // maxChildSize: 0.4,

        Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        //controller: scrollController,
        child: Column(
          children: [
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  "\$${provider.totalPrice()}",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                minimumSize: Size(double.infinity, 40),
              ),
              onPressed: () async {
                bool isTrue = true;
                showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(child: CircularProgressIndicator()),
  );
                for (Product product in provider.cart) {
                  if (product.quantityToSend > product.quantity) {
                     Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Durations.long3,
                      content: Text('The quantity is not evalable!'),
                      backgroundColor: Colors.red,
                    ));
                    isTrue = false;
                    break;
                  }
                }
                List<Map<String, dynamic>> products = [];
                if (isTrue) {
                  print("enter here");

                  for (Product product in provider.cart) {
                    products.add(ProductToSend(
                            productId: product.id.toString(),
                            quantity: product.quantityToSend.toString())
                        .toJson());
                  }
                  // print(jsonEncode(products));
                  // print('token : ${userInfoModel!.token}');

                  bool status = await AddOrderService().addOrder(
                      body: json.encode(products), token: storage.getString("token")!);
                    
                  if (status) {
                     Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Order Successfully Added'),
                      backgroundColor: kPrimaryColor,
                    ));
                    provider.cart = [];
                  }
                }
              },
              child: Text(
                "Check Out",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

