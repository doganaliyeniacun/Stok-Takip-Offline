import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/components/image_asset.dart';
import 'package:stok_takip_offline/components/in_out_search_dialog.dart';
import 'package:stok_takip_offline/components/list_item.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/core/components/buttons/elevated_button1.dart';
import 'package:stok_takip_offline/core/components/text_form_field/text_form_field1.dart';
import 'package:stok_takip_offline/pages/main/controller/controller_main_page.dart';
import 'package:stok_takip_offline/pages/stock_in_out/controller/stock_in_out_controller.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class StockInOutPage extends StatefulWidget {
  StockInOutPage({Key? key}) : super(key: key);

  @override
  State<StockInOutPage> createState() => _StockInOutPageState();
}

class _StockInOutPageState extends State<StockInOutPage> {
  GlobalKey<FormState> formState = GlobalKey();

  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  final StockInOutController _stockInOutController =
      Get.put(StockInOutController());
  final MainController _mainController = Get.find();

  late BuildContext publicContext;

  @override
  Widget build(BuildContext context) {
    publicContext = context;
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
                  child: TopBanner(
                    color: AppConstant.blueShade200,
                  ),
                ),
                Expanded(
                  flex: 6,
                  // child: //CenterImage(),
                  child: Container(
                    height: Get.height * 0.10,
                    child: Obx(
                      () => _stockInOutController.checkListItem.value
                          ? ListItem(_stockInOutController.itemList.value)
                          : CenterImage(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: stockInOutForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding stockInOutForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: formState,
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.02),
              row1(publicContext),
              SizedBox(height: Get.height * 0.02),
              row2(),
              SizedBox(height: Get.height * 0.02),
              row3(),
              SizedBox(height: Get.height * 0.02),
              inOutButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Row inOutButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton1(
            name: "in",
            // function: () {
            //   if (formState.currentState!.validate()) {
            //     formState.currentState!.save();
            //   }
            // },
            function: () {
              _stockInOutController.check = false;
              if (formState.currentState!.validate()) {
                formState.currentState!.save();
                _stockInOutController.stockIn();
                _stockInOutController.checkListItem.value = false;
              }
            },
            color: AppConstant.blueShade200,
          ),
        ),
        SizedBox(width: Get.width * 0.04),
        Expanded(
          child: CustomElevatedButton1(
            name: "out",
            function: () {
              _stockInOutController.checkOut();
              if (formState.currentState!.validate()) {
                formState.currentState!.save();
                _stockInOutController.stockOut();
                _stockInOutController.checkListItem.value = false;
              }
            },
            color: AppConstant.blueShade200,
          ),
        ),
      ],
    );
  }

  CustomTextFormField1 row3() {
    return CustomTextFormField1(
        name: "unit",
        textInputType: TextInputType.number,
        textEditingController: _stockInOutController.row3,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value.toString().isEmpty) {
            return "unitRequired".tr;
          } else if (_stockInOutController.checkUnitValue(value.toString()) ||
              _stockInOutController.check) {
            return "zero".tr;
          }
          // else if(){
          //   return "0 dan küçük olamaz.";
          // }
        });
  }

  CustomTextFormField1 row2() {
    return CustomTextFormField1(
      name: "explanation",
      textEditingController: _stockInOutController.row2,
      textInputAction: TextInputAction.next,
    );
  }

  Row row1(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField1(
              name: "code",
              textInputType: TextInputType.number,
              textEditingController: _stockInOutController.row1,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (!_stockInOutController.checkCode(value.toString())) {
                  return "stockNotFound".tr;
                }
              }),
        ),
        GestureDetector(
          onTap: () {
            searchStock(publicContext);
            _stockInOutController.getSearchList();
          },
          child: Icon(
            Icons.find_replace_sharp,
            size: 30,
            color: AppConstant.blueShade200,
          ),
        ),
        SizedBox(width: Get.width * 0.03),
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
        ? _stockInOutController.row1.text = barcodeScanRes
        : barcodeScanRes = "";
  }
}
