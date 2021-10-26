class DatabaseModel {
  late int id;
  String? stockName;
  String? stockCode;
  late int unit;
  late double purchasePrice;
  late double salePrice;
  String? explanation;
  late String updateDate;
  late int stockIn;
  late int stockOut;

  DatabaseModel({
    this.stockName,
    this.stockCode,
    this.unit = 0,
    this.purchasePrice = 0.0,
    this.salePrice = 0.0,
    this.explanation = "",
    this.updateDate = "",
    this.stockIn = 0,
    this.stockOut = 0,
  });

  DatabaseModel.withId({
    required this.id,
    this.stockName,
    this.stockCode,
    this.unit = 0,
    this.purchasePrice = 0.0,
    this.salePrice = 0.0,
    this.explanation = "",
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['stockName'] = stockName;
    map['stockCode'] = stockCode;
    map['unit'] = unit;
    map['purchasePrice'] = purchasePrice;
    map['salePrice'] = salePrice;
    map['explanation'] = explanation;    
    map['stockIn'] = stockIn;
    map['stockOut'] = stockOut;
    return map;
  }

  Map<String, dynamic> toMapWithId() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['stockName'] = stockName;
    map['stockCode'] = stockCode;
    map['unit'] = unit;
    map['purchasePrice'] = purchasePrice;
    map['salePrice'] = salePrice;
    map['explanation'] = explanation;
    map['stockIn'] = stockIn;
    map['stockOut'] = stockOut;
    return map;
  }

  DatabaseModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    stockName = map['stockName'];
    stockCode = map['stockCode'];
    unit = map['unit'];
    purchasePrice = map['purchasePrice'];
    salePrice = map['salePrice'];
    explanation = map['explanation'];
    updateDate = map['updateDate'];
    stockIn = map['stockIn'];
    stockOut = map['stockOut'];
  }
}
