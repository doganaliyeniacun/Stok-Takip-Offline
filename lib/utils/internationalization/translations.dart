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
          'stockName': 'Stok Adı',
          'purchasePrice': 'Alış Fiyatı',
          'salePrice': 'Satış Fiyatı',
          'save': 'Kaydet',

          //delete - update
          'delete': 'Sil',
          'update': 'Güncelle',

          //report
          'totalStockIn': 'Toplam Stok Girişi',
          'totalStockOut': 'Toplam Stok Çıkışı',
          'outgoingMoney': 'Yapılan Ödeme',
          'incomingMoney': 'Alınan Ödeme',
          'cashReport': 'KASA RAPORU',
          'balance': 'Toplam Gelir',
          'daily': 'GÜNLÜK',
          'weekly': 'HAFTALIK',
          'monthly': 'AYLIK',

          //validation
          'stockNameRequired': 'Lütfen Stok Adı alanını doldurunuz.',
          'stockCodeRequired': 'Lütfen Stok Kodu alanını doldurunuz.',
          'unitRequired': 'Lütfen Adet alanını doldurunuz.',
          'usedStockName': 'Bu stok adı daha önce kullanılmış.',
          'usedStockCode': 'Bu stok kodu daha önce kullanılmış.',
          'snackSave':'Stok kayededildi',
          'stockNotFound': 'Stok bulunamadı.',
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
          'stockName': 'Stock Name',
          'purchasePrice': 'Purchase Price',
          'salePrice': 'Sale Price',
          'save': 'Save',

          //delete - update
          'delete': 'Delete',
          'update': 'Update',

          //report
          'totalStockIn': 'Total Stock In',
          'totalStockOut': 'Total Stock Out',
          'outgoingMoney': 'Outgoing Money',
          'incomingMoney': 'Incoming Money',
          'cashReport': 'CASH REPORT',
          'balance': 'Balance',
          'daily': 'DAİLY',
          'weekly': 'WEEKLY',
          'monthly': 'MONTHLY',

          //validation
          'stockNameRequired': 'Please Fill The Stock Name Area.',
          'stockCodeRequired': 'Please Fill The Stock Code Area.',
          'unitRequired': 'Please Fill The Unit Area.',
          'usedStockName': 'This Stock Name Has Been Used Before.',
          'usedStockCode': 'This Stock Code Has Been Used Before.',
          'snackSave':'Succesfull',
          'stockNotFound': 'Stock Not Found.',
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
