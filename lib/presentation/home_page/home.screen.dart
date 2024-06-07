import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
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
                MainTopWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    children: [
                      ContentTitleWidget(
                        title: "Sedang Berlangsung",
                        subtitle: "Lihat Selengkapnya",
                      ),
                      Obx(
                        () {
                          if (controller.isLoading.value) {
                            return Padding(
                              padding: const EdgeInsets.all(defaultMargin),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (controller.ordersList.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.all(defaultMargin),
                              child: Center(
                                child: Text(
                                  'Order Tidak Bisa Ditemukan',
                                  style: tsBodySmallMedium(black),
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.ordersList.length > 3
                                ? 3
                                : controller.ordersList.length,
                            itemBuilder: (context, index) {
                              final order = controller.ordersList[index];
                              final laundryId = int.parse(
                                order.laundryId.toString(),
                              );

                              int adjustedIndex = laundryId - 1;
                              adjustedIndex >= 0 ? adjustedIndex : 0;

                              final jenisPesanan =
                                  controller.jenisList.isNotEmpty
                                      ? controller.jenisList[adjustedIndex]
                                          .toString()
                                      : 'Loading...';
                              return DetailWidget(
                                onPressed: () {
                                  controller.goToDetailTransactionPage(index);
                                },
                                paddingValues: 10,
                                transcationNum: order.noPemesanan ?? "",
                                title: '${jenisPesanan} - ${order.namaPemesan}',
                                subTitle: order.beratLaundry == null
                                    ? "Berat Belum Di Hitung"
                                    : "${order.beratLaundry}",
                                bottomTitle: order.totalHarga == null
                                    ? "Harga Belum Di Hitung"
                                    : "Rp. ${order.totalHarga}",
                              );
                            },
                          );
                        },
                      ),
                      ContentTitleWidget(
                        title: "Riwayat Transaksi",
                        subtitle: "Lihat Selengkapnya",
                      ),
                      Obx(
                        () {
                          if (controller.isLoading.value) {
                            return Padding(
                              padding: const EdgeInsets.all(defaultMargin),
                              child: Center(child: CircularProgressIndicator()),
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
                            itemCount: controller.ordersList.length > 3
                                ? 3
                                : controller.ordersList.length,
                            itemBuilder: (context, index) {
                              final order = controller.ordersList[index];
                              final laundryId = int.parse(
                                order.laundryId.toString(),
                              );

                              int adjustedIndex = laundryId - 1;
                              adjustedIndex >= 0 ? adjustedIndex : 0;

                              final jenisPesanan =
                                  controller.jenisList.isNotEmpty
                                      ? controller.jenisList[adjustedIndex]
                                          .toString()
                                      : 'Loading...';
                              return DetailWidget(
                                onPressed: () {
                                  controller.goToDetailRiwayatPage(index);
                                },
                                paddingValues: 10,
                                transcationNum:
                                    "No. Transaksi - ${order.noPemesanan}",
                                title: "${jenisPesanan} - ${order.namaPemesan}",
                                subTitle: order.beratLaundry == null
                                    ? "Berat Belum Di Hitung"
                                    : "${order.beratLaundry}",
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
                                        order.tanggalPemesanan ?? "",
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
    return Container(
      color: secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat Datang",
                  style: tsLabelLargeSemibold(primaryColor),
                ),
                Obx(() => Text(
                      controller.userData['username'] ?? "Anon",
                      style: tsTitleMediumSemibold(primaryColor),
                    )),
              ],
            ),
            InkWell(
              onTap: () {
                // Add your notification logic here
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 45,
                width: 45,
                child: const Icon(
                  Icons.notifications_rounded,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainTopWidget extends StatelessWidget {
  const MainTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: secondaryColor,
          height: 150,
        ),
        Container(
          color: primaryColor,
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: primaryColor,
          ),
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      child: MainChoiceWidget(
                    onPressed: () {
                      Get.toNamed(Routes.ORDERANTARJEMPUT_PAGE);
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
                      Get.toNamed(Routes.ORDERANTARJEMPUT_PAGE);
                    },
                    imageAssets: 'assets/img_home/delivery2.png',
                    mainTitle: 'Antar Mandiri',
                  )),
                ],
              ),
            ],
          ),
        ),
      ],
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
