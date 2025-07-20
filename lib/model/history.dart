class History {
  late int id;
  late String time;
  late String date;
  late double orderPrice;
  late dynamic productsInfo;

  History({
    required this.id,
    required this.time,
    required this.date,
    required this.orderPrice,
    required this.productsInfo,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['time'] = time;
    map['date'] = date;
    map['orderPrice'] = orderPrice;
    map['idProductsList'] = productsInfo;
    return map;
  }

  History.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    time = map['time'];
    date = map['date'];
    orderPrice = map['orderPrice'];
    productsInfo = map['productsInfo'];
  }
}
