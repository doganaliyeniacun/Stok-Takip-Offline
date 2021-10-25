import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:stok_takip_offline/components/delete_update_search.dart';
import 'package:stok_takip_offline/components/image_asset.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/core/components/buttons/elevated_button1.dart';
import 'package:stok_takip_offline/core/components/text_form_field/text_form_field1.dart';
import 'package:stok_takip_offline/pages/stock_delete_update/controller/stock_delete_update_controller.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class StockDeleteUpdatePage extends StatelessWidget {
  StockDeleteUpdatePage({Key? key}) : super(key: key);

  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  late BuildContext _publicContext;

  final StockDeleteUpdateController _stockDeleteUpdateController =
      Get.put(StockDeleteUpdateController());

  @override
  Widget build(BuildContext context) {
    _publicContext = context;
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
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formState,
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.15,
                            ),
                            stockCodeText(),
                            SizedBox(height: Get.height * 0.01),
                            searchAndBarcode(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row searchAndBarcode() {
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton1(
            name: "delete",
            // function: () {
            //   if (formState.currentState!.validate()) {
            //     formState.currentState!.save();
            //   }
            // },
            function: () {
              if (formState.currentState!.validate()) {
                formState.currentState!.save();
                _stockDeleteUpdateController.deleteStock(_publicContext);
              }
            },
            color: AppConstant.blueShade200,
          ),
        ),
        SizedBox(width: Get.height * 0.01),
        Expanded(
          child: CustomElevatedButton1(
            name: "update",
            // function: () {
            //   if (formState.currentState!.validate()) {
            //     formState.currentState!.save();
            //   }
            // },
            function: () {
              if (formState.currentState!.validate()) {
                formState.currentState!.save();
                Get.toNamed("/update");
                _stockDeleteUpdateController.putUpdateValue();
              }
            },
            color: AppConstant.blueShade200,
          ),
        ),
      ],
    );
  }

  Row stockCodeText() {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField1(
            name: "code",
            textInputType: TextInputType.number,
            textEditingController: _stockDeleteUpdateController.row1,
            validator: (value) {
              bool check =
                  !_stockDeleteUpdateController.checkCode(value.toString());
              if (value.toString().isEmpty) {
                return "stockCodeRequired".tr;
              }
              if (check) {
                return "stockNotFound".tr;
              }
            },
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () => searchStock(_publicContext),
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
                  AppConstant.barcodeImg,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
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
        ? _stockDeleteUpdateController.row1.text = barcodeScanRes
        : barcodeScanRes = "";
  }
}
