class ShoppingCart {
  late int? id;
  late int productId;

  ShoppingCart({
    required this.id,
    required this.productId,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productId'] = productId;
    return map;
  }

  ShoppingCart.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    productId = map['productId'];
  }
}
