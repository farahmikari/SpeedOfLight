import 'package:delivery_app/constants.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/screens/products_screen/widgets/addTo_cart_botton.dart';
import 'package:delivery_app/services/add_favorite_product.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
final Product product;

  const ProductDetailsScreen({super.key, required this.product});
  static String id="details";
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.product.name ?? 'Product Name',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Product Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    widget.product.image ?? 'https://via.placeholder.com/150',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Product Name
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.product.name ?? 'Product Name',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // color: kPrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () async {
                            widget.product.isFavorite = true;
                            print("favorite");
                            setState(() {});
                            
                            try {
                              await AddFavoriteProduct().addFavoriteProduct(
                                token: storage.getString("token")!,
                                idProduct: widget.product.id.toString(),
                              );
                              
                            } catch (e) {
                              print(e);
                              debugPrint("error in favorite");
                            }
                          },
                          icon: Icon(
                            widget.product.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.product.isFavorite
                                ? Colors.red
                                : Colors.black,
                          )),
                      Text(
                        '${widget.product.price}' ?? '\$\$',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Product Price
              // Text(
              //   'price : ',
              //   style: TextStyle(
              //     fontSize: 17,
              //     color: Colors.grey,
              //   ),
              // ),
              // Text(
              //   '${product.price}' ?? '\$\$',
              //   style: TextStyle(
              //     fontSize: 13,
              //   ),
              // ),
              const SizedBox(height: 12),
              // Product Description
              Container(
                height: 30,
                width: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: kPrimaryColor,
                ),
                child: const Center(
                  child: Text(
                    ' Description ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.product.description ?? 'Product description',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Add to Cart Button
              AddtoCartBotton(
                product: widget.product,
              )
            ],
          ),
        ),
      ),
    );
  }
}
