import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/order_page/order_page.screen.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';
import 'package:wash_it/widget/common/main_container_widget.dart';

import 'controllers/home.controller.dart';
import 'models/OrdersModel.dart';

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
                        title: "Status Pesanan",
                      ),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.ordersList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: lightGrey.withOpacity(0.3),
                              highlightColor: lightGrey.withOpacity(0.1),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: defaultMargin),
                                child: MainContainerWidget(
                                  color: primaryColor,
                                  height: 138,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          );
                        } else if (controller.ordersList.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(60),
                            child: Center(
                              child: Text("Tidak ada pesanan",
                                  style: tsBodyMediumMedium(darkGrey)),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: controller.ordersList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final order = controller.ordersList[index];
                              return HomeShowDetail.ShowDetailHome(
                                  order: order);
                            },
                          );
                        }
                      }),
                      ContentTitleWidget(
                        title: "Riwayat Pesanan",
                      ),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.ordersList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: lightGrey.withOpacity(0.3),
                              highlightColor: lightGrey.withOpacity(0.1),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: defaultMargin),
                                child: MainContainerWidget(
                                  color: primaryColor,
                                  height: 138,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          );
                        } else if (controller.ordersList.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(60),
                            child: Center(
                              child: Text("Tidak ada pesanan",
                                  style: tsBodyMediumMedium(darkGrey)),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: controller.ordersList.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final order = controller.ordersList[index];
                              return HomeShowDetail.ShowDetailHome(
                                  order: order);
                            },
                          );
                        }
                      }),
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

class HomeShowDetail extends StatelessWidget {
  const HomeShowDetail.ShowDetailHome({super.key, required this.order});

  final OrdersModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: InkWell(
        onTap: () =>
            Get.toNamed(Routes.TRANSACTION_PAGE, arguments: [order.id]),
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
                          "${order.noPemesanan}",
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
                            "Estimasi: ",
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
                          "${order.namaPemesan}",
                          style: tsBodySmallSemibold(black),
                        ),
                        Text(
                          order.jenisPemesanan == 'antar_jemput'
                              ? "Antar Jemput"
                              : "Antar Mandiri",
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          order.beratLaundry == null
                              ? "Berat belum tercatat"
                              : "${order.beratLaundry}",
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          "${order.namaLaundry}",
                          style: tsBodySmallSemibold(successColor),
                        ),
                      ],
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "Jl.Pala no 108, Binagritya blok A, Medono, Pekalongan Barat, Pekalongan, Indonesia",
                        style: tsLabelLargeSemibold(grey),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        maxLines: 4,
                      ),
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
