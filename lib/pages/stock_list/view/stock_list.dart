import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/components/image_asset.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/core/components/buttons/elevated_button1.dart';
import 'package:stok_takip_offline/core/components/text_form_field/text_form_field1.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class StockListPage extends StatelessWidget {
  StockListPage({Key? key}) : super(key: key);

  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffold,
        body: myBody(),
      ),
    );
  }

  Widget myBody() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: TopBanner(color: AppConstant.blueShade200),
          ),
          SizedBox(height: Get.height * 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: searchBar(),
          ),
          const Expanded(flex: 10, child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formState,
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton1(
                            // function: () {
                            //   if (formState.currentState!.validate()) {
                            //     formState.currentState!.save();
                            //   }
                            // },
                            function: () => print("test"),
                            color: AppConstant.blueShade200,
                            icon: const Icon(
                              Icons.arrow_drop_up,
                              size: 50,
                            ),
                          ),
                        ),
                        SizedBox(width: Get.height * 0.01),
                        Expanded(
                          child: CustomElevatedButton1(
                            // function: () {
                            //   if (formState.currentState!.validate()) {
                            //     formState.currentState!.save();
                            //   }
                            // },
                            function: () => print("test"),
                            color: AppConstant.blueShade200,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return CustomTextFormField1(
        name: "code",
        textInputType: TextInputType.text,
        prefixIcon: Icons.search
        // validator: (value) =>
        //     value == "1" ? "Bilinmeyen Stok Kodu" : null,
        // onSaved: (p0) => print("Kayıt başarılı"),
        );
  }
}

class test extends CustomTextFormField1 {
  test({Key? key}) : super(key: key);
}
