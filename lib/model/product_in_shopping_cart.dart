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

  ProductInShoppingCart.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    productId = map['productId'];
    name = map['name'];
    price = map['price'];
    image = map['image'];
  }
}
