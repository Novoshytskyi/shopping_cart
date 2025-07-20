class ProductInShoppingCart {
  late int? id;
  late int productId;
  late String name;
  late double price;
  late String image;

  ProductInShoppingCart({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['productId'] = productId;
    name = map['name'];
    price = map['price'];
    image = map['image'];
    return map;
  }

  ProductInShoppingCart.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    productId = map['productId'];
    name = map['name'];
    price = map['price'];
    image = map['image'];
  }
}
