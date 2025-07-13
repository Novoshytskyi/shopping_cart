// class ShoppingCart {
//   late int? id;
//   late int? productId;

//   ShoppingCart({
//     required this.id,
//     required this.productId,
//   });

//   Map<String, dynamic> toMap() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['productId'] = productId;
//     return map;
//   }

//   ShoppingCart.fromMap(Map<String, dynamic> map) {
//     id = map['id'];
//     productId = map['productId'];
//   }
// }

class ShoppingCart {
  late int? id;
  // late int productId;
  late String name;
  late String price;
  late String image;

  ShoppingCart({
    required this.id,
    // required this.productId,
    required this.name,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    // map['productId'] = productId;
    map['name'] = name;
    map['price'] = price;
    map['image'] = image;
    return map;
  }

  ShoppingCart.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    // productId = map['productId'];
    name = map['name'];
    price = map['price'];
    image = map['image'];
  }
}
