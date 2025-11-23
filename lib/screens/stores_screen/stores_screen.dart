import 'package:delivery_app/constants.dart';
import 'package:delivery_app/providers/products_provider.dart';
import 'package:delivery_app/providers/stores_provider.dart';
import 'package:delivery_app/screens/products_screen/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoresScreen extends StatelessWidget {
  final String categoryName;

  const StoresScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          '$categoryName Stores',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<StoresProvider>(
          builder:
              (BuildContext context, StoresProvider value, Widget? child) =>
                  Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                 
                  controller: value.searchController,
                  decoration: InputDecoration(
                    labelText: 'Search stores',
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        try {
                          value
                              .searchForStoreAsync(value.searchController.text);
                          //value.searchController.clear();
                        } catch (e) {
                          print("no item");
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // List of Stores
              value.items.isEmpty
                  ? Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Text(
                      "No item in this name !",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: value.items.length,
                        itemBuilder: (context, index) => _buildStoreCard(
                          context,
                          value.items[index].id,
                          value.items[index].name ?? "Store Name",
                          value.items[index].image ??
                              'https://via.placeholder.com/150',
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreCard(
      BuildContext context, int? storeId, String storeName, dynamic imageUrl) {
    return Card(
      color: Colors.grey.shade200,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () async {
          if (storeId == null) {
            return;
          }
          await Provider.of<ProductsProvider>(context, listen: false)
              .getProductsAsync(storeId);

          // Navigate to ProductsScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsScreen(storeName: storeName),
            ),
          );
        },
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Placeholder Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  width: 150,
                  height: 75,
                  // fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              // Store Name
              Expanded(
                child: Text(
                  storeName,
                  style: const TextStyle(
                    color: kPrimaryColor,
                    //fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
