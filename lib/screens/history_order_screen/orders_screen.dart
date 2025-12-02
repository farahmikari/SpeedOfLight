import 'package:delivery_app/constants.dart';
import 'package:delivery_app/main.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/services/get_orders.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  static String id = "order history";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'H I S T O R Y  O R D E R',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder<List<Product>>(
          future: GetOrders().getOrder(token: storage.getString("token")!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> orders = snapshot.data!;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  Product order = orders[index];
                  DateTime date = timeParse(order.updated_at);
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor,width: 2),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade200),
                      height: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              '${order.image}',
                              
                              width: 80,
                              height: 85,
                              fit: BoxFit.fill,
                            ),
                          ),
                          //Text('${order.image}'),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${order.name}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    'date order : ${date.day}-${date.month}-${date.year}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'time order : ${date.hour}:${date.minute}:${date.second}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    'price : ${order.price}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              print("history");
              return const Center(
                // child: CircularProgressIndicator(),
                child: Text(
                  'No Orders Yet !',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              );
            }
          }),
    );
  }
}

DateTime timeParse(String? dateTime) {
  DateTime date = DateTime.parse(dateTime!);
  return date;
}
