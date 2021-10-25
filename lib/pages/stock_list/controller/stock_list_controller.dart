import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/database/database_helper.dart';
import 'package:stok_takip_offline/database/database_model.dart';

class StockListController extends GetxController {
  final DatabaseHelper _databaseHelper = Get.find();

  RxList<DatabaseModel> list = <DatabaseModel>[].obs;
  RxList<DatabaseModel> items = <DatabaseModel>[].obs;

  TextEditingController searchController = TextEditingController();

  void getDataOrderBy(String orderBy) {
    _databaseHelper.getAllStockOrderBy(orderBy: orderBy).then(
          (value) => list.value = value,
        );
  }

  void getDataOrderBySearchList(String orderBy) {
    _databaseHelper.getAllStockOrderBy(orderBy: orderBy).then(
          (value) => items.value = value,
        );
  }

  @override
  void onInit() {
    getDataOrderBy("ASC");
    getDataOrderBySearchList("ASC");
    super.onInit();
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
