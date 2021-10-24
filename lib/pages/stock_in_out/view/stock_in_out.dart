import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
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
                              "stock code: ${_stockInOutController.list[index].stockCode.toString()}  unit :${_stockInOutController.list[index].unit.toString()}  explanation: ${_stockInOutController.list[index].explanation.toString()}"),
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
              if (formState.currentState!.validate()) {
                formState.currentState!.save();
                _stockInOutController.stockIn();
              }
            },
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
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value.toString().isEmpty) {
          return "unitRequired".tr;
        }
      },
    );
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
            searchStock();
          },
          child: Icon(
            Icons.find_replace_sharp,
            size: 30,
            color: AppConstant.blueShade200,
          ),
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

  Future<dynamic> searchStock() {
    return showDialog(
      context: publicContext,
      builder: (context) => AlertDialog(
        content: Container(
          height: Get.height * 0.99,
          width: Get.width * 0.99,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppConstant.blueShade200,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextFormField1(
                  name: "stockNameOrCode",
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.search,
                  textEditingController: _stockInOutController.searchController,
                  onChanged: (value) =>
                      _stockInOutController.searchStockList(value.toString()),
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: _stockInOutController.items.length,
                      itemBuilder: (context, index) {
                        var list = _stockInOutController.items[index];
                        return IntrinsicHeight(
                          child: GestureDetector(
                            onTap: () {
                              _stockInOutController.row1.text =
                                  list.stockCode.toString();

                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppConstant.blueShade200),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: Get.width,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10),
                                          ),
                                          color: Colors.blue,
                                        ),
                                        child: Text(
                                          "${list.stockName}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(10),
                                          ),
                                          color: Colors.pink,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Text(
                                              "Stok kodu :",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${list.stockCode}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
