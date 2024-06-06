import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/themes.dart';

class OrderPageScreen3 extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onFinish;
  final String nama;
  final String nomorTelepon;
  final String alamat;
  final String tipeLaundry;
  final String catatan;
  final DateTime jadwalPengambilan;
  final double hargaPerKg;

  const OrderPageScreen3({
    Key? key,
    required this.onBack,
    required this.onFinish,
    required this.nama,
    required this.nomorTelepon,
    required this.alamat,
    required this.tipeLaundry,
    required this.catatan,
    required this.jadwalPengambilan,
    required this.hargaPerKg,
  }) : super(key: key);

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
                _buildStepIndicator("✓", "Isi Form", true),
                _buildStepIndicator("✓", "Pilih Layanan", true),
                _buildStepIndicator("3", "Konfirmasi", false),
              ],
            ),
            SizedBox(height: 10),
            ContentTitleWidget(title: "Pastikan data kamu telah sesuai"),
            SizedBox(height: 20),
            _buildDataBox("Data Pelanggan dan Pesanan", [
              Text("Data Pelanggan", style: tsBodySmallSemibold(black)),
              SizedBox(height: 10),
              _buildDataItem("Nama", "Marlen Edzel"),
              _buildDataItem("Nomor Telepon", "nomorTelepon"),
              _buildDataItem("Alamat", "alamat"),
              SizedBox(height: 10),
              Text("Detail Pesanan", style: tsBodySmallSemibold(black)),
              SizedBox(height: 10),
              _buildDataItem("Tipe Laundry", "tipeLaundry"),
              _buildDataItem("Jadwal Pengambilan",
                  "${jadwalPengambilan.day}/${jadwalPengambilan.month}/${jadwalPengambilan.year}"),
              _buildDataItem("Catatan", "catatan"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Harga per Kg", style: tsBodySmallSemibold(black)),
                  Text("Rp. 5.000,00", style: tsBodySmallSemibold(black)),
                ],
              )
            ]),
            SizedBox(height: 20),
            Text(
                "*Untuk layanan antar jemput diwajibkan membayar biaya minimal per kg",
                style: TextStyle(color: Color(0xFF535C6B))),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: onBack,
                child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Text("Kembali", style: tsBodySmallSemibold(black)),
                ),
              ),
            ),
            SizedBox(width: defaultMargin), // Add some space (horizontal space
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF76ABAE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Get.offNamed(Routes.TRANSACTION_PAGE),
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

  Widget _buildDataBox(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8),
        color: darkGrey,
        strokeWidth: 2,
        dashPattern: [10, 5],
        padding: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget _buildDataItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: tsBodySmallMedium(darkBlue)),
          Text(value, style: tsBodySmallMedium(darkBlue)),
        ],
      ),
    );
  }

  Widget _buildDataItemBold(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(label + ":", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}