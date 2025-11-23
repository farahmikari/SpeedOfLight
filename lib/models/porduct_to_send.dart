class ProductToSend {
  final String productId;
  final dynamic quantity;

  ProductToSend({required this.productId, required this.quantity});

  factory ProductToSend.fromJson(Map<String, dynamic> json) {
    return ProductToSend(
      productId: json['product_id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
    };
  }
}

class ProductToSendList {
  final List<ProductToSend> products;

  ProductToSendList({required this.products});

  factory ProductToSendList.fromJson(List<dynamic> jsonList) {
    return ProductToSendList(
      products: jsonList.map((json) => ProductToSend.fromJson(json)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return products.map((product) => product.toJson()).toList();
  }
}
