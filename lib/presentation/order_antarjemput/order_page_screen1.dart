import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/auth/input_form_widget.dart';
import 'package:get/get.dart';

import '../../widget/common/content_title_widget.dart';

class OrderPageScreen1 extends StatelessWidget {
  final VoidCallback onNext;

  const OrderPageScreen1(
      {Key? key, required this.onNext, required void Function() onFinish})
      : super(key: key);

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
        title: Text("Pesan Laundry", style: tsBodyLargeMedium(black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepIndicator("1", "Isi Form", true),
                _buildStepIndicator("2", "Pilih Layanan", false),
                _buildStepIndicator("3", "Konfirmasi", false),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ContentTitleWidget(title: "Silahkan isi data dibawah ini"),
            ),
            InputFormWidget(
              title: "Nama Pelanggan",
              hintText: "Masukkan nama Anda",
              keyboardType: TextInputType.name,
            ),
            InputFormWidget(
              title: "Nomor Telepon",
              hintText: "Masukkan nomor telepon Anda",
              keyboardType: TextInputType.phone,
            ),
            InputFormWidget(
              title: "Alamat",
              hintText: "Masukkan alamat Anda",
              keyboardType: TextInputType.streetAddress,
            ),
          ],
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
                onPressed: onNext,
                child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Text("Selanjutnya",
                      style: tsBodySmallSemibold(primaryColor)),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildStepIndicator(String number, String text, bool isActive) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 25, // Smaller circle
            height: 25,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFF767676), width: 1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(number,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.black : Color(0xFF767676))),
            ),
          ),
          SizedBox(width: 5),
          Text(text, style: tsLabelLargeMedium(black)) // Smaller text for steps
        ],
      ),
    );
  }
}
