import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stok_takip_offline/pages/main_page/view/main_page.dart';
import 'package:stok_takip_offline/pages/new_stock_page/view/new_stock_page.dart';
import 'package:stok_takip_offline/pages/stock_in_out_page/view/stock_in_out.dart';
import 'package:stok_takip_offline/utils/internationalization/translations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InitTranslations initTranslations = Get.put(InitTranslations());

  @override
  Widget build(BuildContext context) {
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
        // GetPage(name: 'menu1', page: () => null, binding: SampleBind()),
      ],
    );
  }
}
