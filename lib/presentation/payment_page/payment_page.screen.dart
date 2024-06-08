import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/themes.dart';
import 'controllers/payment_page.controller.dart';

class PaymentPageScreen extends GetView<PaymentPageController> {
  PaymentPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_2,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: primaryColor,
        title: Text("Pilih Pembayaran", style: tsBodyLargeMedium(black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: itemsData.length,
                itemBuilder: (context, index) {
                  final data = itemsData[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListViewWidgetItems(
                      data['keyNum'],
                      controller,
                      data['itemTitle'],
                      data['itemImage'],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF76ABAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Get.toNamed(Routes.RECEIPT_PAGE),
                child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Text(
                    "Selanjutnya",
                    style: tsBodySmallSemibold(primaryColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget ListViewWidgetItems(
    numKey, PaymentPageController controller, itemTitle, itemImage) {
  return Obx(() => Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: controller.selectedMethod.value == numKey
                  ? successColor
                  : lightGrey,
              width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Image.asset(
            itemImage,
            height: 20,
            width: 20,
          ),
          title: Text(
            itemTitle,
            style: tsBodySmallRegular(black),
          ),
          trailing: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: lightGrey, width: 2),
            ),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: primaryColor, width: 2),
                color: controller.selectedMethod.value == numKey
                    ? successColor
                    : primaryColor,
              ),
            ),
          ),
          onTap: () {
            controller.selectMethod(numKey);
          },
        ),
      ));
}

class PaymentChoiceDotted extends StatelessWidget {
  const PaymentChoiceDotted({
    super.key,
    required this.selectedMethod,
  });

  final int selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: primaryColor, width: 2),
        color: selectedMethod == 0 ? successColor : primaryColor,
      ),
    );
  }
}

final List<Map<String, dynamic>> itemsData = [
  {
    'keyNum': 0,
    'itemTitle': 'Transfer Bank',
    'itemImage': 'assets/img_transaction/icMastercard.png',
  },
  {
    'keyNum': 1,
    'itemTitle': 'OVO',
    'itemImage': 'assets/img_transaction/ovo.png',
  },
  {
    'keyNum': 2,
    'itemTitle': 'Tunai',
    'itemImage': 'assets/img_transaction/money.png',
  },
];
