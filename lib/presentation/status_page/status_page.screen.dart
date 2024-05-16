import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

import 'controllers/status_page.controller.dart';

class StatusPageScreen extends GetView<StatusPageController> {
  const StatusPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: primaryColor,
        //   title: Text(
        //     'Sedang Berlansung',
        //     style: tsBodyLargeMedium(black),
        //   ),
        //   centerTitle: true,
        // ),
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Container(
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
                            "Pesanan Telah Sampai",
                            style: tsLabelLargeBold(successColor),
                          )
                        ],
                      )
                    ],
                  ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.end,
                  //     children: [
                  //       Text(
                  //         "23 Maret 2024",
                  //         style: tsLabelLargeRegular(black),
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(6),
                  //           color: successColor,
                  //         ),
                  //         height: 30,
                  //         width: 80,
                  //         child: Expanded(
                  //           child: Center(
                  //             child: Text(
                  //               "Selesai",
                  //               style: tsLabelLargeSemibold(primaryColor),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
