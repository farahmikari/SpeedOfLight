import 'package:delivery_app/constants.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/screens/products_screen/product_details_screen.dart';
import 'package:delivery_app/services/get_favorite_product.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  static String id = "Favorite screen";
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "F A V O R I T E ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Icon(
                Icons.favorite,
                color: Colors.white,
              )
            ],
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: FutureBuilder<List<Product>>(
            future: GetFavoriteProduct().getFavoriteProducts(
              token: storage.getString("token")!,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<Product> productFav = snapshot.data!;
                return ListView.builder(
                    itemCount: productFav.length,
                    itemBuilder: (context, index) {
                      print(productFav.length);
                      Product Favorite = productFav[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsScreen(product: Favorite),
                            ),
                          );
                        },
                        child: Container(
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: kPrimaryColor, width: 2),
                                borderRadius: BorderRadius.circular(20),
                                color: kDefaultColor),
                            height: 130,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    '${Favorite.image}',
                                    width: 80,
                                    height: 85,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        '${Favorite.name}',
                                        style: const TextStyle(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      Text(
                                        'price : ${Favorite.price}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      //InkWell()
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    });
              } else {
                return const Center(
                  child: Text("No Favorite Products !",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      )),
                );
              }
            }));
  }
}
