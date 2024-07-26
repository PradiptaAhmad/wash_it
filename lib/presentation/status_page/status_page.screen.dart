import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';
import 'package:wash_it/widget/common/detail_widget.dart';
import 'package:wash_it/widget/common/main_container_widget.dart';
import '../../infrastructure/theme/themes.dart';
import 'controllers/status_page.controller.dart';
import 'package:wash_it/presentation/home_page/models/OrdersModel.dart';

class StatusPageScreen extends GetView<StatusPageController> {
  const StatusPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatusPageController controller = Get.put(StatusPageController());
    return SafeArea(
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
                  title: "Status pesanan",
                  lefttextSize: tsTitleSmallMedium(black),
                ),
                SizedBox(height: 10),
                Obx(
                  () {
                    if (controller.isLoading.value) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.ordersList.length,
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
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: MainContainerWidget(
                              childs: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Order id",
                                              style: tsLabelLargeMedium(grey),
                                            ),
                                            Text(
                                              "#1",
                                              style: tsLabelLargeMedium(black),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 5,
                                                vertical: 2,
                                              ),
                                              child: Text(
                                                "Estimasi: 28 Mei 2024",
                                                style: tsLabelLargeMedium(
                                                    darkGrey),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1),
                                      child: Divider(
                                          color: lightGrey, thickness: 0.5),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Marlen Satriani",
                                              style: tsBodySmallSemibold(black),
                                            ),
                                            Text(
                                              "Antar Jemput",
                                              style: tsLabelLargeSemibold(
                                                  darkGrey),
                                            ),
                                            Text(
                                              "20 Kg",
                                              style: tsLabelLargeSemibold(
                                                  darkGrey),
                                            ),
                                            Text(
                                              "Cuci Kering",
                                              style: tsBodySmallSemibold(
                                                  successColor),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total harga",
                                              style: tsLabelMediumMedium(black),
                                            ),
                                            Text(
                                              "Rp 280.000",
                                              style: tsBodySmallSemibold(black),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: secondaryColor
                                                    .withOpacity(0.2),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 30,
                                                  vertical: 8,
                                                ),
                                                child: Text(
                                                  "Ulas",
                                                  style: tsLabelLargeSemibold(
                                                      secondaryColor),
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
                          );
                        },
                      );
                      // return ListView.builder(
                      //   physics: NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   reverse: true,
                      //   itemCount: controller.ordersList.length,
                      //   itemBuilder: (context, index) {
                      //     final order = controller.ordersList[index];
                      //     final laundryId = order.laundryId != null
                      //         ? int.tryParse(order.laundryId!)
                      //         : null;
                      //
                      //     // Ensure the adjusted index is within bounds
                      //     int adjustedIndex =
                      //         (laundryId != null && laundryId > 0)
                      //             ? laundryId - 1
                      //             : 0;
                      //
                      //     final jenisPesanan = (controller
                      //                 .jenisList.isNotEmpty &&
                      //             adjustedIndex < controller.jenisList.length)
                      //         ? controller.jenisList[adjustedIndex].toString()
                      //         : 'Loading...';
                      //     return DetailWidget(
                      //       onPressed: () {
                      //         Get.toNamed(Routes.TRANSACTION_PAGE,
                      //             arguments: [order.id]);
                      //       },
                      //       transcationNum: order.noPemesanan ?? "",
                      //       title: '${jenisPesanan} - ${order.namaPemesan}',
                      //       subTitle: order.beratLaundry == null
                      //           ? "Berat Belum Di Hitung"
                      //           : "${order.beratLaundry} kg",
                      //       bottomTitle: order.totalHarga == null
                      //           ? "Harga Belum Di Hitung"
                      //           : "Rp. ${order.totalHarga}",
                      //     );
                      //   },
                      // );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
