import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';
import 'package:wash_it/widget/common/detail_widget.dart';

import '../../infrastructure/theme/themes.dart';
import '../history_page/history_page.screen.dart';
import 'controllers/status_page.controller.dart';

class StatusPageScreen extends GetView<StatusPageController> {
  const StatusPageScreen({Key? key}) : super(key: key);
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
                  title: "Sedang Berlangsung",
                  lefttextSize: tsTitleSmallSemibold(black),
                ),
                SizedBox(height: 10),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
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
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
