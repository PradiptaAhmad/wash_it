import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/detail_widget.dart';

import '../../widget/common/content_title_widget.dart';
import 'controllers/history_page.controller.dart';

class HistoryPageScreen extends GetView<HistoryPageController> {
  const HistoryPageScreen({Key? key}) : super(key: key);

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
          ContentTitleWidget(
            title: "Riwayat Transaksi",
            lefttextSize: tsTitleSmallSemibold(black),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return DetailWidget(
                onPressed: () {
                  Get.toNamed(Routes.TRANSACTION_PAGE);
                },
                transcationNum: "No. Transaksi - 00414519797419",
                title: "Cuci Setrika - Marlen",
                subTitle: "Berat - 5Kg",
                bottomTitle: "Rp. 25.000",
                childs: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "23 Maret 2024",
                        style: tsLabelLargeRegular(black),
                      ),
                      InkWell(
                        onTap: () {
                          print("Button Telah Dipencet");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: successColor,
                          ),
                          height: 30,
                          width: 80,
                          child: Expanded(
                            child: Center(
                              child: Text("Selesai",
                                  style: tsLabelLargeSemibold(primaryColor)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ))));
  }
}
