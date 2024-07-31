import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';
import 'package:wash_it/widget/common/main_container_widget.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/themes.dart';
import 'controllers/status_page.controller.dart';

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
                        itemCount: controller.ordersList.length,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final order = controller.ordersList[index];
                          String formattedDate = DateFormat('d MMMM yyyy')
                              .format(DateTime.parse(
                                  order.tanggalEstimasi.toString()));
                          return Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: InkWell(
                              onTap: () => Get.toNamed(Routes.TRANSACTION_PAGE,
                                  arguments: [order.id]),
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
                                                "id Pesanan",
                                                style: tsLabelLargeMedium(grey),
                                              ),
                                              Text(
                                                "${order.noPemesanan}",
                                                style:
                                                    tsLabelLargeMedium(black),
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
                                                  "Estimasi: ${formattedDate}",
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
                                                "${order.namaPemesan}",
                                                style:
                                                    tsBodySmallSemibold(black),
                                              ),
                                              Text(
                                                order.jenisPemesanan ==
                                                        'antar_jemput'
                                                    ? 'Antar Jemput'
                                                    : 'Antar Sendiri',
                                                style: tsLabelLargeSemibold(
                                                    darkGrey),
                                              ),
                                              Text(
                                                order.beratLaundry == null
                                                    ? "Berat belum tercatat"
                                                    : "${order.beratLaundry} Kg",
                                                style: tsLabelLargeSemibold(
                                                    darkGrey),
                                              ),
                                              Text(
                                                "${order.namaLaundry}",
                                                style: tsBodySmallSemibold(
                                                    successColor),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 120,
                                            child: Text(
                                              "${order.alamat}",
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
                                                style:
                                                    tsLabelMediumMedium(black),
                                              ),
                                              Text(
                                                order.totalHarga == null
                                                    ? "Harga belum tercatat"
                                                    : "Rp ${order.totalHarga}",
                                                style:
                                                    tsBodySmallSemibold(black),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Status laundry",
                                                style:
                                                    tsLabelMediumMedium(black),
                                              ),
                                              Text(
                                                '${order.status}',
                                                style: tsBodySmallSemibold(
                                                    secondaryColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
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
