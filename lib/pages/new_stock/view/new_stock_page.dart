import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/components/image_asset.dart';
import 'package:stok_takip_offline/core/components/banner/top_banner.dart';
import 'package:stok_takip_offline/core/components/buttons/elevated_button1.dart';
import 'package:stok_takip_offline/core/components/text_form_field/text_form_field1.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

class NewStockPage extends StatelessWidget {
  NewStockPage({Key? key}) : super(key: key);

  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffold = GlobalKey();

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
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formState,
                        child: Column(
                          children: [
                            CustomTextFormField1(
                              name: "stockName",
                            ),
                            SizedBox(height: Get.height * 0.01),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                CustomTextFormField1(
                                  name: "code",
                                  textInputType: TextInputType.number,
                                  // validator: (value) =>
                                  //     value == "1" ? "Bilinmeyen Stok Kodu" : null,
                                  // onSaved: (p0) => print("Kayıt başarılı"),
                                ),
                                Positioned(
                                  right: Get.width * 0.02,
                                  child: Row(
                                    children: [
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
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: Get.height * 0.01),
                            CustomTextFormField1(
                              name: "unit",
                              prefixIcon: Icons.add_circle_outline_outlined
                            ),
                            SizedBox(height: Get.height * 0.01),
                            CustomTextFormField1(
                              name: "purchasePrice",
                              textInputType: TextInputType.number,
                              prefixIcon: Icons.add_shopping_cart_rounded
                            ),
                            SizedBox(height: Get.height * 0.01),
                            CustomTextFormField1(
                              name: "salePrice",
                              textInputType: TextInputType.number,
                              prefixIcon: Icons.attach_money_sharp
                            ),
                            SizedBox(height: Get.height * 0.01),
                            CustomElevatedButton1(
                              name: "save",
                              // function: () {
                              //   if (formState.currentState!.validate()) {
                              //     formState.currentState!.save();
                              //   }
                              // },
                              function: () => print("test"),
                              color: AppConstant.blueShade200,
                            ),
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
}


class test extends CustomTextFormField1{
  test({Key? key}) : super(key: key);
  
}