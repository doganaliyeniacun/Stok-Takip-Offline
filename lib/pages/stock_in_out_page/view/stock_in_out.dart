import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/components/image_asset.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class StockInOutPage extends StatelessWidget {
  StockInOutPage({Key? key}) : super(key: key);

  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  bool isAutoValidate = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffold,
        body: myBody(),
      ),
    );
  }

  Container myBody() {
    return Container(
      color: Colors.white,
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
                      SizedBox(height: Get.height * 0.02),
                      CustomTextFormField1(
                        name: "code",

                        // validator: (value) =>
                        //     value == "1" ? "Bilinmeyen Stok Kodu" : null,
                        // onSaved: (p0) => print("Kayıt başarılı"),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      CustomTextFormField1(name: "explanation"),
                      SizedBox(height: Get.height * 0.02),
                      CustomTextFormField1(name: "unit"),
                      SizedBox(height: Get.height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton1(
                              name: "in",
                              // function: () {
                              //   if (formState.currentState!.validate()) {
                              //     formState.currentState!.save();
                              //   }
                              // },
                              function: () => print("test"),
                              color: AppConstant.blueShade200,
                            ),
                          ),
                          SizedBox(width: Get.width * 0.04),
                          Expanded(
                            child: CustomElevatedButton1(
                              name: "out",
                              function: () => print("test"),
                              color: AppConstant.blueShade200,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextFormField1 extends StatelessWidget {
  CustomTextFormField1({
    Key? key,
    this.name = "",
    this.validator,
    this.onSaved,
  }) : super(key: key);

  final String name;
  String? Function(String?)? validator;
  void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: name.tr,
        filled: true,
        contentPadding: EdgeInsets.all(10),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}

class CustomElevatedButton1 extends StatelessWidget {
  CustomElevatedButton1({
    Key? key,
    this.name = "",
    this.function,
    this.color = Colors.blue,
  }) : super(key: key);

  final String name;
  final Color color;

  void Function()? function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: Container(
        height: Get.height * 0.06,
        width: Get.width * 0.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(name.tr),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
    );
  }
}
