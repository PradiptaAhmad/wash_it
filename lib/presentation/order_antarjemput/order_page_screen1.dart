import 'package:flutter/material.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/auth/input_form_widget.dart';

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
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Pesan Laundry", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildStepIndicator("1", "Isi Form", true),
                _buildStepIndicator("2", "Pilih Layanan", false),
                _buildStepIndicator("3", "Konfirmasi", false),
              ],
            ),
            SizedBox(height: 10),
            ContentTitleWidget(title: "Silahkan isi data dibawah ini"),
            SizedBox(height: 10),
            InputFormWidget(
              title: "Nama Pelanggan",
              hintText: "Masukkan nama Anda",
            ),
            InputFormWidget(
              title: "Nomor Telepon",
              hintText: "Masukkan nomor telepon Anda",
              // keyboardType: TextInputType.phone,
            ),
            InputFormWidget(
              title: "Alamat",
              hintText: "Masukkan alamat Anda",
              // keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 80),
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
                child:
                    Text("Selanjutnya", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildStepIndicator(String number, String text, bool isActive) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
          SizedBox(width: 8),
          Expanded(
              child: Text(text,
                  style: TextStyle(
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                      color: Color(0xFF767676),
                      fontSize: 14))), // Smaller text for steps
        ],
      ),
    );
  }
}
