import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Selamat Pagi, Mau Cuci Apa Hari Ini?",
                    style: tsBodyMediumSemibold(black),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img_home/user.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: mainChoiceWidget(
                          'Antar Jemput', 'assets/img_home/delivery1.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: mainChoiceWidget(
                          'Antar Mandiri', 'assets/img_home/delivery2.png')),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    "Sedang Berlangsung",
                    style: tsBodyMediumSemibold(black),
                  )),
                  Text(
                    "Lihat Selengkapnya",
                    style: tsLabelLargeMedium(darkGrey),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            onGoingWidget("Cuci Setrika - Marlen", "Berat - 5Kg", "Rp. 25.000"),
            SizedBox(
              height: 20,
            ),
            onGoingWidget("Cuci Setrika - Bawwaz", "Berat - 5Kg", "Rp. 25.000"),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    "Riwayat Transaksi",
                    style: tsBodyMediumSemibold(black),
                  )),
                  Text(
                    "Lihat Selengkapnya",
                    style: tsLabelLargeMedium(darkGrey),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1.5,
                    blurRadius: 2,
                    offset: Offset(0.5, 2), // changes position of shadow
                  ),
                ],
              ),
              height: 150,
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No. Transaksi - 00414519797419",
                      style: tsLabelLargeRegular(darkGrey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/img_home/default.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cuci Setrika - Bawwaz",
                              style: tsBodySmallSemibold(black),
                            ),
                            Text(
                              "Berat - 5Kg",
                              style: tsLabelLargeSemibold(darkGrey),
                            ),
                            Text(
                              "Rp. 25.000",
                              style: tsLabelLargeBold(successColor),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "23 Maret 2024",
                            style: tsLabelLargeRegular(black),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: successColor,
                            ),
                            height: 30,
                            width: 80,
                            child: Expanded(
                              child: Center(
                                child: Text(
                                  "Selesai",
                                  style: tsLabelLargeSemibold(primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    )));
  }
}

Widget mainChoiceWidget(mainTitle, imageAssets) {
  return Container(
    decoration: BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1.5,
          blurRadius: 2,
          offset: Offset(0.5, 2), // changes position of shadow
        ),
      ],
    ),
    height: 110,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageAssets),
              fit: BoxFit.cover,
            ),
          ),
          height: 50,
          width: 50,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          mainTitle,
          style: tsBodySmallSemibold(black),
        )
      ],
    ),
  );
}

Widget onGoingWidget(upText, midText, botText) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1.5,
          blurRadius: 2,
          offset: Offset(0.5, 2), // changes position of shadow
        ),
      ],
    ),
    height: 120,
    width: double.infinity,
    child: Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "No. Transaksi - 00414519797419",
            style: tsLabelLargeRegular(darkGrey),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: AssetImage('assets/img_home/default.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 60,
                width: 60,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    upText,
                    style: tsBodySmallSemibold(black),
                  ),
                  Text(
                    midText,
                    style: tsLabelLargeSemibold(darkGrey),
                  ),
                  Text(
                    botText,
                    style: tsLabelLargeBold(successColor),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}
