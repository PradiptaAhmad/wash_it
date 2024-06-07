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
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.all(defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainWelcomeTitle(
                          userName: "${controller.userData['username']}",
                        ),
                        Container(
                          padding: EdgeInsets.only(top: defaultMargin),
                          child: Row(
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
                        ),
                        ContentTitleWidget(
                            title: "Sedang Berlangsung",
                            subtitle: "Lihat Selengkapnya"),
                        Obx(() {
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
                                'Order Tidak Bisa Ditemukan',
                                style: tsBodySmallMedium(black),
                              )),
                            );
                          }
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.ordersList.length > 3
                                  ? 3
                                  : controller.ordersList.length,
                              // reverse: true,
                              itemBuilder: (context, index) {
                                final order = controller.ordersList[index];
                                int safeIndex = 0;
                                safeIndex =
                                    int.parse(order.laundryId.toString()) - 1;
                                final jenisPesanan =
                                    controller.jenisList[safeIndex].toString();
                                return DetailWidget(
                                  onPressed: () {
                                    controller.goToDetailTransactionPage(index);
                                  },
                                  paddingValues: 10,
                                  transcationNum: order.noPemesanan ?? "",
                                  title:
                                      '${jenisPesanan} - ${order.namaPemesan}',
                                  subTitle: order.beratLaundry == null
                                      ? "Berat Belum Di Hitung"
                                      : "${order.beratLaundry}",
                                  bottomTitle: order.totalHarga == null
                                      ? "Harga Belum Di Hitung"
                                      : "Rp. ${order.totalHarga}",
                                );
                              });
                        }),
                        ContentTitleWidget(
                            title: "Riwayat Transaksi",
                            subtitle: "Lihat Selengkapnya"),
                        Obx(() {
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
                              )),
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
                                int safeIndex = 0;
                                safeIndex =
                                    int.parse(order.laundryId.toString()) - 1;
                                final jenisPesanan =
                                    controller.jenisList[safeIndex].toString();
                                return DetailWidget(
                                  onPressed: () {
                                    controller.goToDetailRiwayatPage(index);
                                  },
                                  paddingValues: 10,
                                  transcationNum:
                                      "No. Transaksi - ${order.noPemesanan}",
                                  title:
                                      "${jenisPesanan} - ${order.namaPemesan}",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                              });
                        }),
                      ],
                    ),
                  ),
                ))));
  }
}

class MainWelcomeTitle extends StatelessWidget {
  const MainWelcomeTitle({
    this.userName,
    super.key,
  });

  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Selamat Datang", style: tsLabelLargeSemibold(darkGrey)),
            Text(userName ?? "Anon", style: tsTitleMediumSemibold(black)),
          ],
        ),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(),
            height: 45,
            width: 45,
            child: const Icon(
              Icons.notifications_rounded,
              color: darkGrey,
            ),
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
