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
          ContentTitleWidget(title: "Riwayat"),
          HistoryWidget(),
        ],
      ),
    ))));
  }
}

Widget HistoryWidget() {
  return DetailWidget(
    onPressed: () {
      Get.toNamed(Routes.HISTORY_DETAIL_PAGE);
    },
    transcationNum: "TRX-0001",
    title: "Cuci Setrika - Bawwaz",
    subTitle: "Berat - 5Kg",
    bottomTitle: "Rp. 25.000",
    images: 'assets/img_home/default.png',
    childs: Container(
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
    ),
  );
}
