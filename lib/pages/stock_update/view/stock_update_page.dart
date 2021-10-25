import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/components/image_asset.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/core/components/buttons/elevated_button1.dart';
import 'package:stok_takip_offline/core/components/text_form_field/text_form_field1.dart';
import 'package:stok_takip_offline/database/database_helper.dart';
import 'package:stok_takip_offline/database/database_model.dart';
import 'package:stok_takip_offline/pages/new_stock/controller/new_stock_controller.dart';
import 'package:stok_takip_offline/pages/stock_delete_update/controller/stock_delete_update_controller.dart';
import 'package:stok_takip_offline/pages/stock_update/controller/stock_update_controller.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class StockUpdatePage extends StatefulWidget {
  StockUpdatePage({Key? key}) : super(key: key);

  @override
  State<StockUpdatePage> createState() => _StockUpdatePageState();
}

class _StockUpdatePageState extends State<StockUpdatePage> {
  GlobalKey<FormState> formState = GlobalKey();

  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  final StockUpdateController _stockUpdateController = Get.find();
  final StockDeleteUpdateController _stockDeleteUpdateController = Get.find();

  DatabaseHelper databaseHelper = Get.put(DatabaseHelper());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffold,
        body: myBody(),
      ),
    );
  }

  Widget myBody() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        //not :constainedeBox sayfanın scroll yapıldığında uzunluğunu belirlemene yarıyor
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: Get.height * 0.95),
          //not :intrinsicHeight Eğer Expanded widget var ise buna göre uzunluk sağlıyor yoksa hata dönüyor
          child: IntrinsicHeight(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: TopBanner(color: AppConstant.blueShade200),
                ),
                const Expanded(
                  flex: 6,
                  child: CenterImage(),
                ),
                Expanded(
                  flex: 7,
                  child: newStockForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding newStockForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: formState,
          child: Column(
            children: [
              row1(),
              SizedBox(height: Get.height * 0.01),
              row2(),
              SizedBox(height: Get.height * 0.01),
              row3(),
              SizedBox(height: Get.height * 0.01),
              row4(),
              SizedBox(height: Get.height * 0.01),
              row5(),
              SizedBox(height: Get.height * 0.01),
              saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  CustomElevatedButton1 saveButton() {
    return CustomElevatedButton1(
      name: "save",
      function: () {
        if (formState.currentState!.validate()) {
          formState.currentState!.save();
          _stockUpdateController.saveFunc();
          checkStockDeleteUpdate();
        }
      },
      color: AppConstant.blueShade200,
    );
  }

  CustomTextFormField1 row5() {
    return CustomTextFormField1(
      name: "salePrice",
      textInputType: TextInputType.number,
      prefixIcon: Icons.attach_money_sharp,
      textEditingController: _stockUpdateController.row5,
      textInputAction: TextInputAction.done,
    );
  }

  CustomTextFormField1 row4() {
    return CustomTextFormField1(
      name: "purchasePrice",
      textInputType: TextInputType.number,
      prefixIcon: Icons.add_shopping_cart_rounded,
      textEditingController: _stockUpdateController.row4,
      textInputAction: TextInputAction.next,
    );
  }

  CustomTextFormField1 row3() {
    return CustomTextFormField1(
      name: "unit",
      prefixIcon: Icons.add_circle_outline_outlined,
      textEditingController: _stockUpdateController.row3,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
    );
  }

  Widget row2() {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField1(
              name: "code",
              textInputType: TextInputType.text,
              textEditingController: _stockUpdateController.row2,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (_stockUpdateController.checkStockCode(value.toString())) {
                  return "usedStockCode".tr;
                }
                if (_stockUpdateController.row2.text.isEmpty) {
                  return "stockCodeRequired".tr;
                }
              }),
        ),
        SizedBox(width: Get.width * 0.02),
        GestureDetector(
          onTap: () => scanQR(),
          child: Container(
            height: Get.height * 0.05,
            child: Image.asset(
              "assets/barcode.png",
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  CustomTextFormField1 row1() {
    return CustomTextFormField1(
      name: "stockName",
      textEditingController: _stockUpdateController.row1,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (_stockUpdateController.checkStockName(value.toString())) {
          return "usedStockName".tr;
        }
        if (_stockUpdateController.row1.text.isEmpty) {
          return "stockNameRequired".tr;
        }
      },
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = '';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    barcodeScanRes != "-1"
        ? _stockUpdateController.row2.text = barcodeScanRes
        : barcodeScanRes = "";
  }

  void checkStockDeleteUpdate() {
    _stockDeleteUpdateController.getAllData();
    _stockDeleteUpdateController.row1.clear();
  }
}
