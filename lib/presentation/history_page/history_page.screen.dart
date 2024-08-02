import 'dart:io';

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/auth/auth_text_field.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../widget/common/content_title_widget.dart';
import '../../widget/common/main_container_widget.dart';
import '../../widget/decorations/circle_tab_indicator.dart';
import 'controllers/history_page.controller.dart';

class HistoryPageScreen extends GetView<HistoryPageController> {
  const HistoryPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final HistoryPageController controller = Get.put(HistoryPageController());
    return Scaffold(
        body: SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchOrdersData();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: EdgeInsets.all(defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContentTitleWidget(
                  title: "Riwayat Transaksi",
                  lefttextSize: tsTitleSmallMedium(black),
                ),
                SizedBox(height: 10),
                TabBar(
                  labelColor: black,
                  unselectedLabelColor: darkGrey,
                  indicatorColor: secondaryColor,
                  dividerColor: Colors.transparent,
                  labelStyle: tsBodySmallSemibold(black),
                  controller: controller.tabController,
                  splashBorderRadius: BorderRadius.circular(50),
                  indicator: CircleTabIndicator(
                    color: black,
                    radius: 4,
                  ),
                  tabs: const [
                    Tab(text: "Selesai"),
                    Tab(text: "Dibatalkan"),
                  ],
                ),
                SizedBox(
                  height: screenHeight * screenWidth,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      Column(
                        children: [
                          Obx(() {
                            if (controller.isLoading.value) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.ordersList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    Shimmer.fromColors(
                                  baseColor: lightGrey.withOpacity(0.3),
                                  highlightColor: lightGrey.withOpacity(0.1),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: defaultMargin),
                                    child: MainContainerWidget(
                                      color: primaryColor,
                                      height: 187,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              );
                            } else if (controller.ordersList.isEmpty) {
                              return Center(child: Text("Tidak ada Riwayat"));
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                reverse: true,
                                itemCount: controller.ordersList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final order = controller.ordersList[index];
                                  return MainDetailView(
                                      order: order, controller: controller);
                                },
                              );
                            }
                          }),
                        ],
                      ),
                      Container(
                        child: Center(
                          child: Text("Tidak ada Riwayat"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class MainDetailView extends StatelessWidget {
  const MainDetailView(
      {super.key, required this.order, required this.controller});

  final Map<String, dynamic> order;
  final controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: InkWell(
        onTap: () => Get.toNamed(Routes.TRANSACTION_PAGE,
            arguments: [order['id'], 'histories']),
        child: MainContainerWidget(
          childs: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "id Pesanan",
                          style: tsLabelLargeMedium(grey),
                        ),
                        Text(
                          "${order['no_pemesanan']}",
                          style: tsLabelLargeMedium(black),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          child: Text(
                            "Estimasi: ${DateFormat('d MMMM yyyy').format(DateTime.parse(order['tanggal_estimasi'].toString() == 'null' ? "2007-07-31 00:00:00" : order['tanggal_estimasi'].toString()))}",
                            style: tsLabelLargeMedium(darkGrey),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Divider(color: lightGrey, thickness: 0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${order['nama_pemesan']}",
                          style: tsBodySmallSemibold(black),
                        ),
                        Text(
                          order['jenis_pemesanan'] == 'antar_jemput'
                              ? "Antar Jemput"
                              : "Antar Mandiri",
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          order['berat_laundry'] == null
                              ? "Berat belum tercatat"
                              : "${order['berat_laundry']} Kg",
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          "${order['nama_laundry']}",
                          style: tsBodySmallSemibold(successColor),
                        ),
                      ],
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "${order['alamat']}",
                        style: tsLabelLargeSemibold(grey),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        maxLines: 4,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total harga",
                          style: tsLabelMediumMedium(black),
                        ),
                        Text(
                          order['total_harga'] == null
                              ? "Harga belum tercatat"
                              : '${order['total_harga']}',
                          style: tsBodySmallSemibold(black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            enableDrag: true,
                            isDismissible: true,
                            scrollControlDisabledMaxHeightRatio: 0.7,
                            sheetAnimationStyle: AnimationStyle(
                              duration: Durations.medium1,
                              curve: Curves.easeInOut,
                            ),
                            backgroundColor: primaryColor,
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultMargin),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: InkWell(
                                          onTap: () => Get.back(),
                                          child: Icon(
                                            Icons.close_rounded,
                                            color: darkGrey,
                                          ),
                                        ),
                                      ),
                                      RatingBar.builder(
                                        itemPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        glow: false,
                                        itemSize: 60,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star_rate_rounded,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          controller.rating.value = rating;
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Divider(
                                            color: lightGrey, thickness: 1),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Tulis ulasan kamu!",
                                          style: tsBodyMediumMedium(black),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      ExtendedTextField(
                                        onChanged: (value) {
                                          controller.review.value = value;
                                        },
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          hintText: 'Aku suka disko',
                                          hintStyle:
                                              tsBodySmallMedium(darkGrey),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: secondaryColor,
                                                  width: 2)),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: lightGrey, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: warningColor, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          fillColor: primaryColor,
                                          filled: true,
                                        ),
                                      ),
                                      SizedBox(height: defaultMargin),
                                      InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: secondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          height: 50,
                                          child: Center(
                                            child: Text("Kirim",
                                                style: tsBodySmallSemibold(
                                                    primaryColor)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: secondaryColor.withOpacity(0.2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 8,
                              ),
                              child: Text(
                                "Ulas",
                                style: tsLabelLargeSemibold(secondaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
