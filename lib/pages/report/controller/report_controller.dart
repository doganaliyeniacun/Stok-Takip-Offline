import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stok_takip_offline/database/database_helper.dart';
import 'package:stok_takip_offline/database/database_model.dart';

class ReportController extends GetxController {
  RxList<DatabaseModel> listNow = <DatabaseModel>[].obs;
  RxList<DatabaseModel> listWeek = <DatabaseModel>[].obs;
  RxList<DatabaseModel> listMonth = <DatabaseModel>[].obs;

  final DatabaseHelper _databaseHelper = Get.put(DatabaseHelper());

  @override
  void onInit() {
    getDataDaily();
    getDataWeekly();
    getDataMonthly();
    super.onInit();
  }

  void getDataDaily() {
    _databaseHelper
        .getAllStockWhereUpdateDate(dateTimeNow(), dateTimeNow())
        .then((value) => listNow.value = value);
  }

  void getDataWeekly() {
    _databaseHelper
        .getAllStockWhereUpdateDate(dateTimeWeekly(), dateTimeNow())
        .then((value) => listWeek.value = value);
  }

  void getDataMonthly() {
    _databaseHelper
        .getAllStockWhereUpdateDate(dateTimeMonthly(), dateTimeNow())
        .then((value) => listMonth.value = value);
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
}
