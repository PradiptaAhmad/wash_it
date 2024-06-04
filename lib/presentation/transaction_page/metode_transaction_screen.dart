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
  int _selectedMethod = -1;

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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _selectedMethod == 0 ? secondaryColor : lightGrey, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/img_transaction/icMastercard 1.png',
                        height: 10,
                        width: 10,
                      ),
                      SizedBox(width: 5),
                      Image.asset(
                        'assets/img_transaction/dana 1.png',
                        height: 10,
                        width: 10,
                      ),
                      SizedBox(width: 5),
                      Image.asset(
                        'assets/img_transaction/gopay2 1.png',
                        height: 10,
                        width: 10,
                      ),
                      SizedBox(width: 5),
                      Image.asset(
                        'assets/img_transaction/ovo 1.png',
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                  title: Text(
                    "E-Wallet/Transfer Bank/Debit",
                    style: tsLabelLargeMedium(black),
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
                        color: _selectedMethod == 0 ? successColor : primaryColor,
                      ),
                    ),
                  ),
                  onTap: () {
                    _selectMethod(0);
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _selectedMethod == 1 ? successColor : lightGrey,width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Image.asset(
                    'assets/img_transaction/money.png',
                    height: 20,
                    width: 20,
                  ),
                  title: Text(
                      "Tunai",
                    style: tsLabelLargeMedium(black),
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
                        color: _selectedMethod == 1 ? successColor : primaryColor,
                      ),
                    ),
                  ),
                  onTap: () {
                    _selectMethod(1);
                  },
                ),
              ),
              SizedBox(height: 500),
              ButtonWidget(
                backgroundColor: secondaryColor,
                child: Text(
                  "Proses",
                  style: tsLabelLargeMedium(primaryColor),
                ),
                onPressed: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
