import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/detail_widget.dart';
import '../../widget/common/content_title_widget.dart';
import 'controllers/history_page.controller.dart';

class HistoryPageScreen extends GetView<HistoryPageController> {
  const HistoryPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.all(defaultMargin),
                      child: CircularProgressIndicator(),
                    ));
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
                        final laundryId = int.parse(
                          order.laundryId.toString(),
                        );

                        int adjustedIndex = laundryId - 1;
                        adjustedIndex >= 0 ? adjustedIndex : 0;

                        final jenisPesanan = controller.jenisList.isNotEmpty
                            ? controller.jenisList[adjustedIndex].toString()
                            : 'Loading...';
                        return DetailWidget(
                          onPressed: () {
                            controller.goToDetailRiwayatPage(index);
                          },
                          transcationNum:
                              "No. Transaksi - " + order.noPemesanan!,
                          title: "${jenisPesanan} - ${order.namaPemesan}",
                          subTitle: order.beratLaundry == null
                              ? "Berat Belum Di Hitung "
                              : "${order.beratLaundry}",
                          bottomTitle: order.totalHarga == null
                              ? "Harga Belum Di Hitung"
                              : "Rp. ${order.totalHarga}",
                          childs: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  order.tanggalPemesanan.toString().substring(
                                      0,
                                      order.tanggalPemesanan.toString().length -
                                          3),
                                  style: tsLabelLargeRegular(black),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: successColor,
                                  ),
                                  height: 30,
                                  width: 80,
                                  child: Center(
                                    child: Text("Selesai",
                                        style:
                                            tsLabelLargeSemibold(primaryColor)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
