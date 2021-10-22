import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/components/image_asset.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/core/components/buttons/elevated_button1.dart';
import 'package:stok_takip_offline/core/components/text_form_field/text_form_field1.dart';
import 'package:stok_takip_offline/pages/stock_in_out/controller/stock_in_out_controller.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class StockInOutPage extends StatelessWidget {
  StockInOutPage({Key? key}) : super(key: key);

  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  StockInOutController _stockInOutController = Get.put(StockInOutController());

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
                Expanded(
                  flex: 6,
                  // child: //CenterImage(),
                  child: Container(
                    height: Get.height * 0.10,
                    child: Obx(
                      () => ListView.builder(
                        itemCount: _stockInOutController.list.length,
                        itemBuilder: (context, index) => Center(
                          child: Text(
                              "stock code: ${_stockInOutController.list[index].stockCode.toString()}  unit :${_stockInOutController.list[index].unit.toString()}"),
                        ),
                      ),
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
              row1(),
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
            function: () => _stockInOutController.stockIn(),
            color: AppConstant.blueShade200,
          ),
        ),
        SizedBox(width: Get.width * 0.04),
        Expanded(
          child: CustomElevatedButton1(
            name: "out",
            function: () => _stockInOutController.stockOut(),
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
    );
  }

  CustomTextFormField1 row2() {
    return CustomTextFormField1(
      name: "explanation",
    );
  }

  Row row1() {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField1(
            name: "code",
            textInputType: TextInputType.number,
            textEditingController: _stockInOutController.row1,
            // validator: (value) =>
            //     value == "1" ? "Bilinmeyen Stok Kodu" : null,
            // onSaved: (p0) => print("Kayıt başarılı"),
          ),
        ),
        Icon(
          Icons.find_replace_sharp,
          size: 30,
          color: AppConstant.blueShade200,
        ),
        SizedBox(width: Get.width * 0.03),
        Container(
          height: Get.height * 0.05,
          child: Image.asset(
            "assets/barcode.png",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
