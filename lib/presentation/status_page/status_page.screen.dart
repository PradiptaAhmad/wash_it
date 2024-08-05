import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wash_it/presentation/status_page/widgets/status_categories_button_widget.dart';
import 'package:wash_it/widget/common/categories_widget.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: secondaryColor,
              title: Text('Status Pesanan',
                  style: tsTitleSmallMedium(primaryColor)),
            ),
            SizedBox(height: 10),
            StatusCategoriesButtonWidget(controller: controller),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchOrdersData();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.ordersList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            height: 200,
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
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () => Get.toNamed(Routes.TRANSACTION_PAGE,
                                  arguments: [order['id'], 'order']),
                              borderRadius: BorderRadius.circular(20),
                              child: MainContainerWidget(
                                childs: Padding(
                                  padding: const EdgeInsets.all(defaultMargin),
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
                                                "${order['no_pemesanan']}",
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
                                                  "Estimasi: ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(order['tanggal_estimasi'].toString()))}",
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
                                                "${order['nama_pemesan']}",
                                                style:
                                                    tsBodySmallSemibold(black),
                                              ),
                                              Text(
                                                order['jenis_pemesanan'] ==
                                                        'antar_jemput'
                                                    ? 'Antar Jemput'
                                                    : 'Antar Sendiri',
                                                style: tsLabelLargeSemibold(
                                                    darkGrey),
                                              ),
                                              Text(
                                                order['berat_laundry'] == null
                                                    ? "Berat belum tercatat"
                                                    : "${order['berat_laundry']} Kg",
                                                style: tsLabelLargeSemibold(
                                                    darkGrey),
                                              ),
                                              Text(
                                                "${order['nama_laundry']}",
                                                style: tsBodySmallSemibold(
                                                    successColor),
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
                                                order['total_harga'] == null
                                                    ? "Belum tercatat"
                                                    : "${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(order['total_harga'])}",
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
                                                '${order['status']}',
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
