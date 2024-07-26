import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/home_page/models/OrdersModel.dart';
import 'package:wash_it/widget/common/detail_widget.dart';
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
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(defaultMargin),
                                  child: CircularProgressIndicator(),
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

                                  return MainDetailView(
                                      order: order, jenisPesanan: jenisPesanan);
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
      {super.key, required this.order, required this.jenisPesanan});

  final OrdersModel order;
  final jenisPesanan;

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
                          "Order id",
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
                          "${jenisPesanan}",
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
                          order.totalHarga == null
                              ? "Harga belum tercatat"
                              : '${order.totalHarga}',
                          style: tsBodySmallSemibold(black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
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
