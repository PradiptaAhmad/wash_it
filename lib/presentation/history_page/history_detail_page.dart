import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Iconsax.receipt,
                          size: 30,
                          color: successColor,
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: 40,
                          lineThickness: 2,
                          dashLength: 5,
                          dashColor: successColor,
                        ),
                        Icon(
                          Iconsax.wallet_1,
                          size: 30,
                          color: successColor,
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: 40,
                          lineThickness: 2,
                          dashLength: 5,
                          dashColor: successColor,
                        ),
                        Icon(
                          Iconsax.bubble,
                          size: 30,
                          color: successColor,
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: 40,
                          lineThickness: 2,
                          dashLength: 5,
                          dashColor: successColor,
                        ),
                        Icon(
                          Iconsax.location,
                          size: 30,
                          color: successColor,
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          lineLength: 40,
                          lineThickness: 2,
                          dashLength: 5,
                          dashColor: successColor,
                        ),
                        Icon(
                          Iconsax.verify,
                          size: 30,
                          color: successColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("23/03", style: tsBodySmallRegular(black)),
                          Text("Est.", style: tsBodySmallRegular(black)),
                          Text("25/03", style: tsBodySmallRegular(black)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Center(
                  child: Text("Pesanan Telah Selesai",
                      style: tsBodySmallMedium(black))),
              SizedBox(height: 20),
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
              detailDataWidget("Nama Pelanggan", "Adit Rajin Mengaji"),
              detailDataWidget("Nomor Ponsel", "081245678908"),
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
              Center(
                child: RatingBar.builder(
                  itemPadding: EdgeInsets.symmetric(horizontal: 8),
                  glow: false,
                  itemSize: 40,
                  ignoreGestures: true,
                  initialRating: 4,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              SizedBox(height: 20),
              // ButtonWidget(
              //   text: "Beri Penilaian",
              //   backgroundColor: secondaryColor,
              //   onPressed: () {},
              // ),
            ],
          ),
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
