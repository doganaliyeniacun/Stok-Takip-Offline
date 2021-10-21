import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class StokTakipTranlations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'tr_TR': {
          'menu1': 'Stok\nGiriş - Çıkış',
          'menu2': 'Yeni Stok',
          'menu3': 'Stok\nSil - Güncelle',
          'menu4': 'Stok Listele',
          'menu5': 'Stok Raporu',
          'menu6': 'Veritabanı',

          //stock in-out
          'code': 'Stok Kodu',
          'explanation': 'Açıklama (Opsiyonel)',
          'unit': 'Adet',
          'in': 'Stok Girişi',
          'out': 'Stok Çıkışı',

          //new stock
          'stockName': 'Stok Adı (Zorunlu)',
          'purchasePrice': 'Alış Fiyatı',
          'salePrice': 'Satış Fiyatı',
          'save': 'Kaydet',
        },
        'en_US': {
          'menu1': 'Stock\nIn - Out',
          'menu2': 'New Stock',
          'menu3': 'Stock\nDelete - Update',
          'menu4': 'Stock List',
          'menu5': 'Report',
          'menu6': 'Database',

          //stock in-out
          'code': 'Stock Code',
          'explanation': 'Explanation (Optional)',
          'unit': 'Unit',
          'in': 'Stock In',
          'out': 'Stock Out',

          //new stock
          'stockName': 'Stock Name (Required)',
          'purchasePrice': 'Purchase Price',
          'salePrice': 'Sale Price',
          'save': 'Save',
        }
      };
}

class InitTranslations extends GetxController {
  @override
  void onReady() {
    Get.updateLocale(Locale(Get.deviceLocale.toString()));
    super.onReady();
  }
}
