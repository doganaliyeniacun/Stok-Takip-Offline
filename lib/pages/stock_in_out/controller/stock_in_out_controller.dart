import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/database/database_helper.dart';
import 'package:stok_takip_offline/database/database_model.dart';

class StockInOutController extends GetxController {
  DatabaseHelper _databaseHelper = Get.find();

  RxList<DatabaseModel> list = <DatabaseModel>[].obs;
  RxList<DatabaseModel> items = <DatabaseModel>[].obs;

  Rx<DatabaseModel> itemList = DatabaseModel().obs;
  RxBool checkListItem = false.obs;

  TextEditingController row1 = TextEditingController();
  TextEditingController row2 = TextEditingController();
  TextEditingController row3 = TextEditingController();

  TextEditingController searchController = TextEditingController();

  void getData() async {
    await _databaseHelper.getAllStock().then((value) {
      list.value = value;
    });
  }

  void getSearchList() async {
    await _databaseHelper.getAllStock().then((value) {
      items.value = value;
    });
  }

  @override
  void onReady() {
    getData();
    getSearchList();
    super.onReady();
  }

  void stockIn() {
    if (checkCode(row1.text)) {
      _databaseHelper.incrementUnit(
        int.parse(row3.text),
        getId(row1.text),
        explanation: row2.text,
      );
      getData();
      clearText();
    }
  }

  void stockOut() {
    if (checkCode(row1.text)) {
      _databaseHelper.decrementUnit(
        int.parse(row3.text),
        getId(row1.text),
        explanation: row2.text,
      );
      getData();
      clearText();
    }
  }

  void clearText() {
    row1.clear();
    row2.clear();
    row3.clear();
  }

  // int unitIncrement(int unit) {
  //   int increment = 0;

  //   list.forEach((element) {
  //     increment += element.unit + unit;
  //   });
  //   return increment;
  // }

  // int unitDecrement(int unit) {
  //   int decrement = 0;

  //   list.forEach((element) {
  //     decrement -= element.unit + unit;
  //   });
  //   return decrement;
  // }

  bool checkCode(String code) {
    bool check = false;
    // list.where((value) => value.stockCode.toString().contains(code));
    list.forEach((element) {
      if (element.stockCode == code) {
        check = true;
      }
    });
    return check;
  }

  bool checkUnitValue(String value) {
    bool check = false;

    // list.where((value) => value.stockCode.toString().contains(code));
    if (0 > int.parse(value)) {
      check = true;
    }
    // for (var item in list) {
    //   int total = 0;
    //   total += item.unit - int.parse(value);
    //   if (total < 0 && item.stockCode == row1.text) {
    //     check = true;
    //   }
    // }
    return check;
  }

  bool check = false;

  bool checkOut() {
    check = false;
    for (var item in list) {
      int total = 0;
      total += item.unit - int.parse(row3.text);
      if (total < 0 && item.stockCode == row1.text) {
        check = true;
      }
      print(total.toString());
    }

    print(check);
    return check;
  }

  int getId(String code) {
    late int id;
    for (var element in list.value) {
      if (element.stockCode.toString().contains(code.toString())) {
        id = element.id;
        return id;
      }
    }

    return -1;
  }

  void searchStockList(String query) async {
    var stockList = <DatabaseModel>[];
    stockList.addAll(list);
    if (query.isNotEmpty) {
      var searchList = <DatabaseModel>[];
      for (var item in stockList) {
        bool checkQuery = item.stockCode
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item.stockName
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase());

        if (checkQuery) {
          searchList.add(item);
        }
      }
      items.clear();
      items.addAll(searchList);
    }
    if (query.isEmpty) {
      items.clear();
      items.addAll(list);
    }
  }
}
