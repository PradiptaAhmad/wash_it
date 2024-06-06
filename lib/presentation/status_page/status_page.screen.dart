import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';
import 'package:wash_it/widget/common/detail_widget.dart';
import '../../infrastructure/theme/themes.dart';
import 'controllers/status_page.controller.dart';
import 'package:wash_it/presentation/home_page/models/OrdersModel.dart';

class StatusPageScreen extends GetView<StatusPageController> {
  const StatusPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatusPageController controller = Get.put(StatusPageController());
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
                    title: "Sedang Berlangsung",
                    lefttextSize: tsTitleSmallSemibold(black),
                  ),
                  SizedBox(height: 10),
                  Obx(() {
                    if (controller.isLoading.value && controller.ordersList.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.ordersList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(defaultMargin),
                        child: Center(
                          child: Text(
                            'Order Tidak Bisa Ditemukan',
                            style: tsBodySmallMedium(black),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: controller.ordersList.length,
                        itemBuilder: (context, index) {
                          final order = controller.ordersList[index];
                          return DetailWidget(
                            onPressed: () {
                              controller.goToDetailTransactionPage(index);
                            },
                            paddingValues: 10,
                            transcationNum: order.noPemesanan ?? "",
                            title: 'Cuci Setrika - ${order.namaPemesan}',
                            subTitle: order.beratLaundry == null ? "Berat Belum Ada " : "${order.beratLaundry}",
                            bottomTitle: order.totalHarga == null ? "Harga Belum Ada" : "Rp. ${order.totalHarga}",
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
      ),
    );
  }
}