import 'package:delivery_app/constants.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/providers/add_to_cart_provider.dart';
import 'package:flutter/material.dart';

class AddtoCartBotton extends StatefulWidget {
  AddtoCartBotton({super.key, required this.product});
  final Product product;
  @override
  State<AddtoCartBotton> createState() => _AddtoCartBottonState();
}

class _AddtoCartBottonState extends State<AddtoCartBotton> {
  @override
  Widget build(BuildContext context) {
    final provider = AddToCartProvider.of(context);
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            
            backgroundColor: kPrimaryColor,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
          ),
          onPressed: () {
            // Add to Cart Logic
            provider.toogleFavorite(widget.product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Durations.long3,
                content: Text(
                    'Added ${widget.product.name ?? 'Product Name'} to cart'),
              ),
            );
          },
          child: const Text(
            'Add to Cart',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
