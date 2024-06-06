import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
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
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContentTitleWidget(
                  title: "Riwayat Transaksi",
                  lefttextSize: tsTitleSmallSemibold(black),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
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
                        return DetailWidget(
                          onPressed: () {
                            controller.goToDetailRiwayatPage(index);
                          },
                          transcationNum: "No. Transaksi - ${order.noPemesanan}",
                          title: "${order.jenisPemesanan} - ${order.namaPemesan}",
                          subTitle: order.beratLaundry == null ? "Berat Belum Ada " : "${order.beratLaundry}",
                          bottomTitle: order.totalHarga == null ? "Harga Belum Ada" : "Rp. ${order.totalHarga}",
                          childs: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  order.tanggalPemesanan ?? "",
                                  style: tsLabelLargeRegular(black),
                                ),
                                InkWell(
                                  onTap: () {
                                    print("Button Telah Dipencet");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: successColor,
                                    ),
                                    height: 30,
                                    width: 80,
                                    child: Center(
                                      child: Text("Selesai",
                                          style: tsLabelLargeSemibold(primaryColor)),
                                    ),
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
    );
  }
}
