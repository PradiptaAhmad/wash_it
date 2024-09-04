import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/history_page/widgets/history_filter_button.dart';
import 'package:wash_it/presentation/history_page/widgets/history_main_detail_view.dart';
import 'package:wash_it/widgets/shimmer/shimmer_widget.dart';
import 'package:wash_it/widgets/warning/data_is_empty.dart';
import '../../widgets/common/main_container_widget.dart';
import 'controllers/history_page.controller.dart';

class HistoryPageScreen extends GetView<HistoryPageController> {
  const HistoryPageScreen({Key? key}) : super(key: key);u

  @override
  Widget build(BuildContext context) {
    final HistoryPageController controller = Get.put(HistoryPageController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 50),
        child: _buildAppbar(controller),
      ),
      body: RefreshIndicator(
          onRefresh: () async => controller.applyFilter(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return _buildLoading(controller);
                }
                if (controller.ordersList.isEmpty &&
                    controller.filteredOrdersList.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DataIsEmpty("Riwayat pesanan kamu masih kosong"),
                      SizedBox(
                        height: 10,
                      ),
                      MainContainerWidget(
                        onPressed: () => controller.isSelected.value == 0
                            ? controller.onRefresh()
                            : controller.applyFilter(),
                        padding: EdgeInsets.all(8),
                        childs: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Coba Lagi",
                              style: tsLabelLargeMedium(grey),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.refresh,
                              color: grey,
                              size: 15,
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Obx(() => ListView.builder(
                    shrinkWrap: true,
                    controller: controller.scrollController,
                    itemCount: controller.isSelected.value == 0
                        ? controller.ordersList.length
                        : controller.filteredOrdersList.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final order = controller.isSelected.value == 0
                          ? controller.ordersList[index]
                          : controller.filteredOrdersList[index];
                      return Obx(() {
                        if (controller.isLoadingMore.value) {
                          return CupertinoActivityIndicator();
                        } else {
                          return MainDetailView(order: order);
                        }
                      });
                    }));
              }))),
    );
  }
}

Widget _buildAppbar(controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppBar(
        backgroundColor: secondaryColor,
        title: Text('Riwayat Pesanan', style: tsTitleSmallMedium(primaryColor)),
      ),
      SizedBox(height: 10),
      HistoryFilterButton(),
    ],
  );
}

Widget _buildLoading(controller) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: 4,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: defaultMargin),
        child: ShimmerWidget(
          height: 200,
          radius: 10,
        )),
  );
}
