import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/presentation/transaction_page/controllers/metode_transaction_controller.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/themes.dart';
import '../../widget/common/button_widget.dart';

class MetodeTransaction extends StatefulWidget {
  const MetodeTransaction({Key? key}) : super(key: key);

  @override
  _MetodeTransactionState createState() => _MetodeTransactionState();
}

class _MetodeTransactionState extends State<MetodeTransaction> {
  int _selectedMethod = 0;

  void _selectMethod(int methodIndex) {
    setState(() {
      _selectedMethod = methodIndex;
    });
  }

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
                itemCount: 3,
                itemBuilder: (context, index) {
                  final data = itemsData[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListViewWidgetItems(data['keyNum'], _selectedMethod,
                        _selectMethod, data['itemTitle'], data['itemImage']),
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
                onPressed: () => Get.toNamed(Routes.PAYMENT_RECEIPT),
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
    numKey, _selectedMethod, _selectMethod, itemTitle, itemImage) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
          color: _selectedMethod == numKey ? successColor : lightGrey,
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
            color: _selectedMethod == numKey ? successColor : primaryColor,
          ),
        ),
      ),
      onTap: () {
        _selectMethod(numKey);
      },
    ),
  );
}

class PaymentChoiceDotted extends StatelessWidget {
  const PaymentChoiceDotted({
    super.key,
    required int selectedMethod,
  }) : _selectedMethod = selectedMethod;

  final int _selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(color: primaryColor, width: 2),
        color: _selectedMethod == 0 ? successColor : primaryColor,
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
