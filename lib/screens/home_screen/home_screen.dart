import 'package:delivery_app/constants.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/providers/stores_provider.dart';
import 'package:delivery_app/screens/products_screen/product_details_screen.dart';
import 'package:delivery_app/screens/stores_screen/stores_screen.dart';
import 'package:delivery_app/services/get_top3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String id = "home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int categoryHome = 1;

  int categoryFood = 2;

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/home_screen.jpg'),
            const SizedBox(height: 20),
            const Text(
              'Category :',
              style: TextStyle(
                fontSize: 18,
                color: kPrimaryColor,
              ),
            ),
            // Category Images
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryImage(
                      context, 'Home Furniture', 1, Icons.weekend),
                  _buildCategoryImage(context, 'Foods', 2, Icons.restaurant),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // Top Products Text
            const Text(
              'Top 3 Products :',
              style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: 10),
            // Top 3 Vegetables
            FutureBuilder<List<Product>>(
                future: GetTop3().getTop3(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Product> products3 = snapshot.data!;
                    return Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: products3.length,
                        itemBuilder: (context, index) {
                          return _buildVegetableCard(context, products3[index]);
                        },
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                   
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryImage(BuildContext context, String categoryName,
      int? categoryId, dynamic icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () async {
          if (categoryId == null) {
            return;
          }
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(child: CircularProgressIndicator()),
          );
          try {
            await Provider.of<StoresProvider>(context, listen: false)
                .getStoresByCategoryIdAsync(categoryId);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoresScreen(categoryName: categoryName),
              ),
            );
          } catch (e) {
            Navigator.pop(context);
          }

          // Navigate to the corresponding store screen
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              child: Card(
                color: Colors.grey.shade200,
                margin: EdgeInsets.all(10),
                child: Icon(
                  icon,
                  color: kPrimaryColor,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(categoryName,
                style: const TextStyle(
                  fontSize: 10,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildVegetableCard(BuildContext context, Product vegetable) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          // Navigate to ProductDetailsScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: vegetable),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20)),
          height: 120,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  vegetable.image ??
                      'https://m.media-amazon.com/images/I/71yTV1+FI0L.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Product Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      vegetable.name ?? 'Product Name',
                      style: const TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      vegetable.price ?? 'Product Price',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
