import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:stok_takip_offline/database/database_helper.dart';
import 'package:stok_takip_offline/database/database_model.dart';

class NewStockController extends GetxController {
  final DatabaseHelper _databaseHelper = Get.find();

  late TextEditingController row1;
  late TextEditingController row2;
  late TextEditingController row3;
  late TextEditingController row4;
  late TextEditingController row5;

  RxList<DatabaseModel> stockList = <DatabaseModel>[].obs;

  void newStock() {
    _databaseHelper.insert(
      DatabaseModel(
        stockName: row1.text,
        stockCode: row2.text,
        unit: row3.text.isEmpty ? 0 : int.parse(row3.text),
        purchasePrice: row4.text.isEmpty ? 0.0 : double.parse(row4.text),
        salePrice: row5.text.isEmpty ? 0.0 : double.parse(row5.text),
      ),
    );
  }

  void initTextCont() {
    row1 = TextEditingController();
    row2 = TextEditingController();
    row3 = TextEditingController();
    row4 = TextEditingController();
    row5 = TextEditingController();
  }

  void getStockList() async {
    var list = _databaseHelper.getAllStock();
    await list.then(
      (value) => stockList.value = value,
    );
  }

  @override
  void onInit() {
    getStockList();
    initTextCont();
    super.onInit();
  }

  @override
  void onClose() {
    initTextCont();
    super.onClose();
  }

  void clearTextEditing() {
    row1.clear();
    row2.clear();
    row3.clear();
    row4.clear();
    row5.clear();
  }

  void saveCheck(String text) {
    Get.snackbar(
      "!!",
      text.tr,
    );
  }

  void saveFunc() {
    getStockList();
    newStock();
    clearTextEditing();
    saveCheck("snackSave");
  }

  bool checkStockName(String name) {
    bool check = false;
    for (var element in stockList) {
      if (name.isNotEmpty) {
        check = element.stockName.toString().contains(name) ? true : false;
      }
    }
    return check;
  }

  bool checkStockCode(String code) {
    bool check = false;
    for (var element in stockList) {
      if (code.toString().isNotEmpty) {
        check = element.stockCode.toString().contains(code) ? true : false;
      }
    }
    return check;
  }
}
