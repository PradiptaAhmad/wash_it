import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/order_page/order_page.screen.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';
import 'package:wash_it/widget/common/detail_widget.dart';
import 'package:wash_it/widget/common/main_container_widget.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchOrdersData();
            await controller.fetchUserData();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                MainTitleWidget(),
                Container(
                  padding: EdgeInsets.all(defaultMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: primaryColor,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: MainChoiceWidget(
                            onPressed: () {
                              Get.to(() => OrderView(
                                    tipeOrder: "antar_jemput",
                                  ));
                            },
                            imageAssets: 'assets/img_home/delivery1.png',
                            mainTitle: 'Antar Jemput',
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: MainChoiceWidget(
                            onPressed: () {
                              Get.to(() => OrderView(
                                    tipeOrder: "antar_mandiri",
                                  ));
                            },
                            imageAssets: 'assets/img_home/delivery2.png',
                            mainTitle: 'Antar Mandiri',
                          )),
                        ],
                      ),
                      ContentTitleWidget(
                        title: "Sedang berlangsung",
                        subtitle: "Lihat Selengkapnya",
                      ),
                      Obx(
                        () {
                          if (controller.isLoading.value) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: 116,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.04),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            );
                          }
                          if (controller.ordersList.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(defaultMargin),
                              child: Center(
                                child: Text(
                                  'Tidak ada Riwayat',
                                  style: tsBodySmallMedium(black),
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              final order = controller.ordersList[index];
                              final laundryId = order.laundryId != null
                                  ? int.tryParse(order.laundryId!)
                                  : null;

                              int adjustedIndex =
                                  (laundryId != null && laundryId > 0)
                                      ? laundryId - 1
                                      : 0;

                              final jenisPesanan =
                                  (controller.jenisList.isNotEmpty &&
                                          adjustedIndex <
                                              controller.jenisList.length)
                                      ? controller.jenisList[adjustedIndex]
                                          .toString()
                                      : 'Loading...';
                              return DetailWidget(
                                onPressed: () {
                                  Get.toNamed(Routes.TRANSACTION_PAGE,
                                      arguments: [order.id]);
                                  print(order.id);
                                },
                                transcationNum: order.noPemesanan ?? "",
                                title: '${jenisPesanan} - ${order.namaPemesan}',
                                subTitle: order.beratLaundry == null
                                    ? "Berat Belum Di Hitung"
                                    : "${order.beratLaundry} kg",
                                bottomTitle: order.totalHarga == null
                                    ? "Harga Belum Di Hitung"
                                    : "Rp. ${order.totalHarga}",
                              );
                            },
                          );
                        },
                      ),
                      ContentTitleWidget(
                        title: "Riwayat transaksi",
                        subtitle: "Lihat Selengkapnya",
                      ),
                      Obx(
                        () {
                          if (controller.isLoading.value) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  height: 116,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.04),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            );
                          }
                          if (controller.ordersList.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(defaultMargin),
                              child: Center(
                                child: Text(
                                  'Tidak ada Riwayat',
                                  style: tsBodySmallMedium(black),
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: 3,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final order = controller.ordersList[index];
                              final laundryId = order.laundryId != null
                                  ? int.tryParse(order.laundryId!)
                                  : null;

                              int adjustedIndex =
                                  (laundryId != null && laundryId > 0)
                                      ? laundryId - 1
                                      : 0;

                              final jenisPesanan =
                                  (controller.jenisList.isNotEmpty &&
                                          adjustedIndex <
                                              controller.jenisList.length)
                                      ? controller.jenisList[adjustedIndex]
                                          .toString()
                                      : 'Loading...';

                              return DetailWidget(
                                onPressed: () {
                                  Get.toNamed(Routes.TRANSACTION_PAGE,
                                      arguments: [order.id]);
                                  print(order.id);
                                },
                                transcationNum:
                                    "No. Transaksi - ${order.noPemesanan ?? ""}",
                                title:
                                    "${jenisPesanan} - ${order.namaPemesan ?? ""}",
                                subTitle: order.beratLaundry == null
                                    ? "Berat Belum Di Hitung"
                                    : "${order.beratLaundry} kg",
                                bottomTitle: order.totalHarga == null
                                    ? "Harga Belum Di Hitung"
                                    : "Rp. ${order.totalHarga}",
                                childs: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        order.tanggalPemesanan != null
                                            ? order.tanggalPemesanan!.substring(
                                                0,
                                                order.tanggalPemesanan!.length -
                                                    3)
                                            : "",
                                        style: tsLabelLargeRegular(black),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: successColor,
                                        ),
                                        height: 30,
                                        width: 80,
                                        child: Center(
                                          child: Text("Selesai",
                                              style: tsLabelLargeSemibold(
                                                  primaryColor)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainTitleWidget extends GetView<HomeController> {
  const MainTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat datang",
                style: tsBodySmallSemibold(primaryColor),
              ),
              Obx(() => ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: Text(
                    controller.userData['username'] ?? "Anon",
                    style: tsTitleMediumSemibold(primaryColor),
                    overflow: TextOverflow.ellipsis,
                  ))),
            ],
          ),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.NOTIFICATION_PAGE);
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              height: 45,
              width: 45,
              child: const Icon(
                Icons.notifications,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget MainChoiceWidget({required imageAssets, required mainTitle, onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: MainContainerWidget(
      height: 110,
      childs: Column(
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
    ),
  );
}
