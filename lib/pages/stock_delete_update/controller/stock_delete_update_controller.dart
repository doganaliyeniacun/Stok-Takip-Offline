import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/database/database_helper.dart';
import 'package:stok_takip_offline/database/database_model.dart';
import 'package:stok_takip_offline/pages/stock_update/controller/stock_update_controller.dart';

class StockDeleteUpdateController extends GetxController {
  TextEditingController row1 = TextEditingController();
  TextEditingController searchController = TextEditingController();

  RxList<DatabaseModel> list = <DatabaseModel>[].obs;
  RxList<DatabaseModel> items = <DatabaseModel>[].obs;

  final DatabaseHelper _databaseHelper = Get.find();
  final StockUpdateController _stockUpdateController = Get.put(StockUpdateController());

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

  void getAllData() {
    getData();
    getSearchList();
  }

  @override
  void onReady() {
    getData();
    getSearchList();
    super.onReady();
  }

  void deleteStock(BuildContext context) {
    if (checkCode(row1.text)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Alert"),
          content: Text("Delete Stock"),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                deleteOperations();
              },
              child: Text("Yes"),
            ),
          ],
        ),
      );
      //
    }
  }

  void deleteOperations() {
    _databaseHelper.delete(getId(row1.text));
    Get.back();
    row1.clear();
    getData();
    getSearchList();
  }

  void putUpdateValue() {
    for (var element in list.value) {
      if (element.stockCode.toString().contains(row1.text.toString())) {
        _stockUpdateController.id = element.id;
        _stockUpdateController.row1.text = element.stockName.toString();
        _stockUpdateController.row2.text = element.stockCode.toString();
        _stockUpdateController.row3.text = element.unit.toString();
        _stockUpdateController.row4.text = element.purchasePrice.toString();
        _stockUpdateController.row5.text = element.salePrice.toString();
      }
    }
  }

  

  bool checkCode(String code) {
    bool check = false;
    // list.where((value) => value.stockCode.toString().contains(code));
    for (var element in list) {
      if (element.stockCode == code) {
        check = true;
      }
    }
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
