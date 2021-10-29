import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_offline/database/database_helper.dart';
import 'package:stok_takip_offline/pages/database_page/view/database_page.dart';
import 'package:stok_takip_offline/pages/main/view/main_page.dart';
import 'package:stok_takip_offline/pages/new_stock/view/new_stock_page.dart';
import 'package:stok_takip_offline/pages/report/view/report_page.dart';
import 'package:stok_takip_offline/pages/stock_delete_update/view/stock_delete_update_page.dart';
import 'package:stok_takip_offline/pages/stock_in_out/view/stock_in_out.dart';
import 'package:stok_takip_offline/pages/stock_list/view/stock_list.dart';
import 'package:stok_takip_offline/pages/stock_update/view/stock_update_page.dart';

import 'package:stok_takip_offline/utils/internationalization/translations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InitTranslations initTranslations = Get.put(InitTranslations());
  final DatabaseHelper _databaseHelper = Get.put(DatabaseHelper());
  
  @override
  void initState() {
    _databaseHelper.database;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: StokTakipTranlations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('tr', 'TR'),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: '/', page: () => MainPage()),
        GetPage(name: '/menu1', page: () => StockInOutPage()),
        GetPage(name: '/menu2', page: () => NewStockPage()),
        GetPage(name: '/menu3', page: () => StockDeleteUpdatePage()),
        GetPage(name: '/menu4', page: () => StockListPage()),
        GetPage(name: '/menu5', page: () => ReportPage()),
        GetPage(name: '/menu6', page: () => DatabasePage()),
        GetPage(name: '/update', page: () => StockUpdatePage()),
        // GetPage(name: 'menu1', page: () => null, binding: SampleBind()),
      ],
    );
  }
}
