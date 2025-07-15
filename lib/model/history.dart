class History {
  late int id;
  late DateTime dateTime;
  late double orderPrice;
  late List<int> idProductsList;

  History({
    required this.id,
    required this.dateTime,
    required this.orderPrice,
    required this.idProductsList,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['dateTime'] = dateTime;
    map['orderPrice'] = orderPrice;
    map['idProductsList'] = idProductsList;
    return map;
  }

  History.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    dateTime = map['dateTime'];
    orderPrice = map['orderPrice'];
    idProductsList = map['idProductsList'];
  }
}
