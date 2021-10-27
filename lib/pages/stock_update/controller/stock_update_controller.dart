import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:stok_takip_offline/database/database_helper.dart';
import 'package:stok_takip_offline/database/database_model.dart';

class StockUpdateController extends GetxController {
  final DatabaseHelper _databaseHelper = Get.find();

  TextEditingController row1 = TextEditingController();
  TextEditingController row2 = TextEditingController();
  TextEditingController row3 = TextEditingController();
  TextEditingController row4 = TextEditingController();
  TextEditingController row5 = TextEditingController();

  late int id;

  RxList<DatabaseModel> stockList = <DatabaseModel>[].obs;

  void _getStockList() async {
    var list = _databaseHelper.getAllStock();
    await list.then(
      (value) => stockList.value = value,
    );
  }

  @override
  void onInit() {
    _getStockList();
    super.onInit();
  }

  void _clearTextEditing() {
    row1.clear();
    row2.clear();
    row3.clear();
    row4.clear();
    row5.clear();
  }

  void saveCheck(String text) {
    Get.snackbar(
      "alert".tr,
      text.tr,
    );
  }

  void saveFunc() {
    _getStockList();
    _updateRows();
    _clearTextEditing();
    Get.back();
    saveCheck("snackSave");
  }

  void _updateRows() {
    _databaseHelper.update(
      DatabaseModel(
        stockName: row1.text,
        stockCode: row2.text,
        unit: int.parse(row3.text),
        purchasePrice: double.parse(row4.text),
        salePrice: double.parse(row5.text),
        stockIn: checkUnit(),
      ),
      id,
    );
  }

  checkUnit() {    
    bool check = false;
    int unit = 0;
    int stockIn = 0;

    for (var item in stockList) {
      check = item.stockIn < int.parse(row3.text);
      if (item.id == id) {
        if (check) {
          unit += item.stockIn + (int.parse(row3.text) - item.stockIn);
          return unit;
        } else {
          stockIn = int.parse(row3.text);
          return stockIn;
        }
      }
    }

  }

  bool checkStockName(String name) {
    bool check = false;

    for (var element in stockList) {
      if (name.isNotEmpty) {
        if (element.stockName.toString().contains(name) && element.id == id) {
          check = false;
        } else if (element.stockName.toString().contains(name)) {
          check = true;
        } else {
          check = false;
        }
      }
    }
    return check;
  }

  bool checkStockCode(String code) {
    bool check = false;
    for (var element in stockList) {
      if (code.isNotEmpty) {
        if (element.stockCode.toString().contains(code) && element.id == id) {
          check = false;
        } else if (element.stockCode.toString().contains(code)) {
          check = true;
        } else {
          check = false;
        }
      }
    }
    return check;
  }
}
