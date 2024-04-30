import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/button_widget.dart';

class HistoryDetailPage extends StatelessWidget {
  const HistoryDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_2,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: primaryColor,
        title:
            Text("Detail Riwayat Transaksi", style: tsBodyLargeMedium(black)),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "History Detail Page",
                    style: tsBodyMediumMedium(black),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 35,
                  width: 35,
                  child: Icon(Iconsax.call5, color: primaryColor),
                ),
                SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: 35,
                  width: 35,
                  child: Icon(Iconsax.message5, color: primaryColor),
                )
              ],
            ),
            detailDataWidget("No. Pemesanan", "0441768479184"),
            detailDataWidget("Nama Pemesan", "Adit Rajin Mengaji"),
            detailDataWidget("Nomor Telepon", "081245678908"),
            detailDataWidget("Alamat", "Sanggrahan, Karanganyar"),
            detailDataWidget("Tipe Laundry", "Cuci Regular"),
            detailDataWidget("Berat (Kg)", "4 Kg"),
            detailDataWidget("Tanggal Pemesanan", "23 Maret 2024"),
            SizedBox(height: 20),
            Text(
              "Detail Pembayaran",
              style: tsBodyMediumMedium(black),
            ),
            detailDataWidget("Nomor Referensi", "00000876416789"),
            detailDataWidget("Status Pembayaran", "Sukses"),
            detailDataWidget("Waktu Pembayaran", "25-03-2024,  12:22:12"),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Total Harga",
                    style: tsBodyMediumMedium(black),
                  ),
                ),
                Text(
                  "Rp. 12.000,00",
                  style: tsBodyMediumMedium(black),
                ),
              ],
            ),
            SizedBox(height: 20),
            ButtonWidget(
              text: "Login",
              backgroundColor: secondaryColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Widget detailDataWidget(leftTitle, rightTitle) {
  return Column(
    children: [
      SizedBox(height: 10),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftTitle,
              style: tsBodySmallRegular(darkBlue),
              textAlign: TextAlign.left,
            ),
            Text(
              rightTitle,
              style: tsBodySmallRegular(darkBlue),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    ],
  );
}
