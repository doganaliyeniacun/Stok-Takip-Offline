import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stok_takip_offline/core/components/text_form_field/text_form_field1.dart';
import 'package:stok_takip_offline/database/database_model.dart';
import 'package:stok_takip_offline/pages/stock_in_out/controller/stock_in_out_controller.dart';
import 'package:stok_takip_offline/utils/const/const.dart';

Future<dynamic> searchStock(BuildContext context) {
  StockInOutController _stockInOutController = Get.put(StockInOutController());
    return showDialog(
      context: context,
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
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              height: Get.height * 0.10,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  row1(list),
                                  row2(),
                                  row3(list),
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

Expanded row3(DatabaseModel list) {
  return Expanded(
    child: Container(
      width: Get.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(5),
        ),
      ),
      child: Text(
        "${list.stockCode}",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Expanded row2() {
  return Expanded(
    child: Container(
      width: Get.width,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(
        "code".tr,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Expanded row1(DatabaseModel list) {
  return Expanded(
    child: Container(
      width: Get.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
        ),
      ),
      child: Text(
        "${list.stockName}",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
