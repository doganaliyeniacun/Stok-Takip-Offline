import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:stok_takip_offline/database/database_helper.dart';
import 'package:stok_takip_offline/database/database_model.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:permission_handler/permission_handler.dart';

class DatabaseController extends GetxController {
  final DatabaseHelper _databaseHelper = Get.find();

  List docNameList = ["Database.xlsx"];

  List<DatabaseModel> list = <DatabaseModel>[];
  List<DatabaseModel> listNow = <DatabaseModel>[];
  List<DatabaseModel> listWeek = <DatabaseModel>[];
  List<DatabaseModel> listMonth = <DatabaseModel>[];

  void getList() {
    _databaseHelper.getAllStock().then((value) => list = value);
    _databaseHelper
        .getAllStockWhereUpdateDate(dateTimeNow(), dateTimeNow())
        .then((value) => listNow = value);
    _databaseHelper
        .getAllStockWhereUpdateDate(dateTimeWeekly(), dateTimeNow())
        .then((value) => listWeek = value);
    _databaseHelper
        .getAllStockWhereUpdateDate(dateTimeMonthly(), dateTimeNow())
        .then((value) => listMonth = value);
  }

  String dateTimeNow() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    return formatted;
  }

  String dateTimeWeekly() {
    final DateTime now = DateTime.now();
    final weeklyDate = now.add(const Duration(days: -7));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(weeklyDate);

    return formatted;
  }

  String dateTimeMonthly() {
    final DateTime now = DateTime.now();
    final monthlyDate = now.add(const Duration(days: -30));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(monthlyDate);

    return formatted;
  }

  double outgoingMoney(List<DatabaseModel> list) {
    double money = 0;
    if (list.isNotEmpty) {
      for (var item in list) {
        money += item.purchasePrice * item.stockIn;
      }
    }
    return money;
  }

  double incomingMoney(List<DatabaseModel> list) {
    double money = 0;
    if (list.isNotEmpty) {
      for (var item in list) {
        money += item.salePrice * item.stockOut;
      }
    }
    return money;
  }

  double balance(List<DatabaseModel> list) {
    double moneyOut = 0;
    double moneyIn = 0;
    double balance = 0;
    if (list.isNotEmpty) {
      for (var item in list) {
        moneyOut += item.salePrice * item.stockOut;
        moneyIn += item.purchasePrice * item.stockIn;
      }
    }
    balance = moneyOut - moneyIn;
    return balance;
  }

  //Storage permission
  Future getStoragePermission() async {
    if (await Permission.storage.request().isGranted &&
        await Permission.accessMediaLocation.request().isGranted) {
      generateExcel();
    } else if (await Permission.storage.request().isPermanentlyDenied &&
        await Permission.accessMediaLocation.request().isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  //delete database document
  void deleteDoc() async {
    final Directory directory =
        await path_provider.getApplicationDocumentsDirectory();

    String path = directory.path;
    String fileName = "";

    for (var i = 0; i < docNameList.length; i++) {
      fileName = docNameList[i];
      final File file = File('$path/$fileName');
      file.exists().then((value) => file.delete());
    }
  }

  //share documents

  void docBackUpAndShare() async {
    final Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    Share.shareFiles(['${directory.path}/${docNameList[0]}']);
  }

  Future<void> generateExcel() async {
    //delete documents
    getList();
    deleteDoc();

    //Creating a workbook.
    final Workbook workbook = Workbook();

    final Worksheet sheet = workbook.worksheets[0];

    // Enable calculation for worksheet.
    sheet.enableSheetCalculations();

    //data base
    sheet.getRangeByName('A1').columnWidth = 15.0;
    sheet.getRangeByName('B1').columnWidth = 15.0;
    sheet.getRangeByName('C1').columnWidth = 15.0;
    sheet.getRangeByName('D1').columnWidth = 15.0;
    sheet.getRangeByName('E1').columnWidth = 15.0;

    sheet.getRangeByName('A1:E1').cellStyle.backColor = '#00FFFF';

    sheet.getRangeByName('A1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('B1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('C1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('D1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('E1').cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByName('A1').cellStyle.fontSize = 12;
    sheet.getRangeByName('B1').cellStyle.fontSize = 12;
    sheet.getRangeByName('C1').cellStyle.fontSize = 12;
    sheet.getRangeByName('D1').cellStyle.fontSize = 12;
    sheet.getRangeByName('E1').cellStyle.fontSize = 12;

    sheet.getRangeByName('A1').cellStyle.bold = true;
    sheet.getRangeByName('B1').cellStyle.bold = true;
    sheet.getRangeByName('C1').cellStyle.bold = true;
    sheet.getRangeByName('D1').cellStyle.bold = true;
    sheet.getRangeByName('E1').cellStyle.bold = true;

    sheet.getRangeByName('A1').setText("code".tr);
    sheet.getRangeByName('B1').setText("stockName".tr);
    sheet.getRangeByName('C1').setText("unit".tr);
    sheet.getRangeByName('D1').setText("purchasePrice".tr);
    sheet.getRangeByName('E1').setText("salePrice".tr);

    for (var i = 0; i < list.length; i++) {
      sheet.getRangeByName('A${i + 2}').setText(list[i].stockCode);
      sheet.getRangeByName('B${i + 2}').setText(list[i].stockName);
      sheet.getRangeByName('C${i + 2}').setValue(list[i].unit);
      sheet.getRangeByName('D${i + 2}').setNumber(list[i].purchasePrice);
      sheet.getRangeByName('E${i + 2}').setNumber(list[i].salePrice);
    }

    //reports
    //daily
    sheet.getRangeByName('G1:H1').merge();
    sheet.getRangeByName('G1:H1').columnWidth = 19.0;

    sheet.getRangeByName('G1').setText("daily".tr);
    sheet.getRangeByName('G2').setText("outgoingMoney".tr);
    sheet.getRangeByName('H2').setText("incomingMoney".tr);
    sheet.getRangeByName('G4').setText("balance".tr);

    sheet.getRangeByName('G1').cellStyle.fontSize = 12;
    sheet.getRangeByName('G2').cellStyle.fontSize = 12;
    sheet.getRangeByName('H2').cellStyle.fontSize = 12;
    sheet.getRangeByName('G4').cellStyle.fontSize = 12;

    sheet.getRangeByName('G1').cellStyle.bold = true;
    sheet.getRangeByName('G2').cellStyle.bold = true;
    sheet.getRangeByName('H2').cellStyle.bold = true;
    sheet.getRangeByName('G4').cellStyle.bold = true;

    sheet.getRangeByName('G1').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('G2').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('H2').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('G4').cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByName('G1').cellStyle.backColor = '#A7F7A6';
    sheet.getRangeByName('H2').cellStyle.backColor = '#FFC0CB';
    sheet.getRangeByName('G2').cellStyle.backColor = '#00FFFF';
    sheet.getRangeByName('G4:H4').cellStyle.backColor = '#89CFF0';

    sheet.getRangeByName('G3').setNumber(outgoingMoney(listNow));
    sheet.getRangeByName('H3').setNumber(incomingMoney(listNow));
    sheet.getRangeByName('H4').setNumber(balance(listNow));

    //weekly
    sheet.getRangeByName('G6:H6').merge();
    sheet.getRangeByName('G6:H6').columnWidth = 19.0;

    sheet.getRangeByName('G6').setText("weekly".tr);
    sheet.getRangeByName('G7').setText("outgoingMoney".tr);
    sheet.getRangeByName('H7').setText("incomingMoney".tr);
    sheet.getRangeByName('G9').setText("balance".tr);

    sheet.getRangeByName('G6').cellStyle.fontSize = 12;
    sheet.getRangeByName('G7').cellStyle.fontSize = 12;
    sheet.getRangeByName('H7').cellStyle.fontSize = 12;
    sheet.getRangeByName('G9').cellStyle.fontSize = 12;

    sheet.getRangeByName('G6').cellStyle.bold = true;
    sheet.getRangeByName('G7').cellStyle.bold = true;
    sheet.getRangeByName('H7').cellStyle.bold = true;
    sheet.getRangeByName('G9').cellStyle.bold = true;

    sheet.getRangeByName('G6').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('G7').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('H7').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('G9').cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByName('G6').cellStyle.backColor = '#F7E5A6';
    sheet.getRangeByName('H7').cellStyle.backColor = '#FFC0CB';
    sheet.getRangeByName('G7').cellStyle.backColor = '#00FFFF';
    sheet.getRangeByName('G9:H9').cellStyle.backColor = '#89CFF0';

    sheet.getRangeByName('G8').setNumber(outgoingMoney(listWeek));
    sheet.getRangeByName('H8').setNumber(incomingMoney(listWeek));
    sheet.getRangeByName('H9').setNumber(balance(listWeek));

    //monthly

    sheet.getRangeByName('G11:H11').merge();
    sheet.getRangeByName('G11:H11').columnWidth = 19.0;

    sheet.getRangeByName('G11').setText("monthly".tr);
    sheet.getRangeByName('G12').setText("outgoingMoney".tr);
    sheet.getRangeByName('H12').setText("incomingMoney".tr);
    sheet.getRangeByName('G14').setText("balance".tr);

    sheet.getRangeByName('G11').cellStyle.fontSize = 12;
    sheet.getRangeByName('G12').cellStyle.fontSize = 12;
    sheet.getRangeByName('H12').cellStyle.fontSize = 12;
    sheet.getRangeByName('G14').cellStyle.fontSize = 12;

    sheet.getRangeByName('G11').cellStyle.bold = true;
    sheet.getRangeByName('G12').cellStyle.bold = true;
    sheet.getRangeByName('H12').cellStyle.bold = true;
    sheet.getRangeByName('G14').cellStyle.bold = true;

    sheet.getRangeByName('G11').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('G12').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('H12').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('G14').cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByName('G11').cellStyle.backColor = '#FF4747';
    sheet.getRangeByName('H12').cellStyle.backColor = '#FFC0CB';
    sheet.getRangeByName('G12').cellStyle.backColor = '#00FFFF';
    sheet.getRangeByName('G14:H14').cellStyle.backColor = '#89CFF0';

    sheet.getRangeByName('G13').setNumber(outgoingMoney(listMonth));
    sheet.getRangeByName('H13').setNumber(incomingMoney(listMonth));
    sheet.getRangeByName('H14').setNumber(balance(listMonth));

    //Save the excel.
    final List<int> bytes = workbook.saveAsStream();

    final Directory directory =
        await path_provider.getApplicationDocumentsDirectory();

    String path;

    path = directory.path;

    String fileName = 'Database.xlsx';

    final File file = File('$path/$fileName');

    await file.create(recursive: true);

    await file.writeAsBytes(bytes);

    // //Dispose the document.
    workbook.dispose();

    Get.snackbar("alert".tr, "exporting".tr);
  }
}
