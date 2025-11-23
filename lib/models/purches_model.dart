class PurchesModel {
  final String product_id;
  final String quantity;

  PurchesModel({
    required this.product_id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    "product_id":product_id,
    "quantity":quantity
  };
}
