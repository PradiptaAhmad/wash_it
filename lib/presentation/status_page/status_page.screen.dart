import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wash_it/presentation/status_page/widgets/status_categories_button_widget.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/themes.dart';
import '../../widgets/common/main_container_widget.dart';
import '../../widgets/shimmer/shimmer_widget.dart';
import '../../widgets/warning/data_is_empty.dart';
import 'controllers/status_page.controller.dart';

class StatusPageScreen extends GetView<StatusPageController> {
  const StatusPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatusPageController controller = Get.put(StatusPageController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 50),
        child: _buildAppbar(controller),
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.onRefresh(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return _buildLoading();
              }
              if (controller.ordersList.isEmpty ||
                  controller.filteredOrdersList.isEmpty &&
                      controller.selectedFilter.value != 0) {
                return DataIsEmpty("Status pesanan kamu masih kosong");
              }
              return ListView.builder(
                itemCount: controller.selectedFilter.value == 0
                    ? controller.ordersList.length
                    : controller.filteredOrdersList.length,
                shrinkWrap: true,
                reverse: false,
                itemBuilder: (context, index) {
                  final order = controller.ordersList[index];
                  return _buildOrderItem(order);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildAppbar(controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppBar(
        backgroundColor: secondaryColor,
        title: Text('Status Pesanan', style: tsTitleSmallMedium(primaryColor)),
      ),
      SizedBox(height: 10),
      StatusCategoriesButtonWidget(),
    ],
  );
}

Widget _buildLoading() {
  return ListView.builder(
    shrinkWrap: true,
    reverse: false,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 4,
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ShimmerWidget(
        width: double.infinity,
        height: 200,
        radius: 10,
      ),
    ),
  );
}

Widget _buildOrderItem(Map<String, dynamic> order) {
  // Determine color based on order status
  Color statusColor;
  switch (order['status']) {
    case 'Pesanan Telah Dibuat':
      statusColor = pendingOrange;
      break;
    case 'Menunggu Penjemputan':
      statusColor = pendingOrange;
      break;
    case 'Sedang diproses':
      statusColor = pendingOrange;
      break;
    case 'Pesananmu akan segera diantar':
      statusColor = darkBlue;
      break;
    case 'Pesananmu Sedang Diantar':
      statusColor = Colors.blue;
      break;
    case 'Pesanan telah diantar':
      statusColor = successColor;
      break;
    default:
      statusColor = darkGrey;
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "id Pesanan",
                          style: tsLabelLargeMedium(grey),
                        ),
                        Text(
                          "${order['no_pemesanan']}",
                          style: tsLabelLargeMedium(black),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Estimasi: ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(order['tanggal_estimasi'].toString()))}",
                      style: tsLabelLargeMedium(darkGrey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.right,
                    ),
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
                        "${order['nama_pemesan']}",
                        style: tsBodySmallSemibold(black),
                      ),
                      Text(
                        order['jenis_pemesanan'] == 'antar_jemput'
                            ? 'Antar Jemput'
                            : 'Antar Sendiri',
                        style: tsLabelLargeSemibold(darkGrey),
                      ),
                      Text(
                        order['berat_laundry'] == null
                            ? "Berat belum tercatat"
                            : "${order['berat_laundry']} Kg",
                        style: tsLabelLargeSemibold(darkGrey),
                      ),
                      Text(
                        "${order['nama_laundry']}",
                        style: tsBodySmallSemibold(secondaryColor),
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
                        order['total_harga'] == null
                            ? "Belum tercatat"
                            : "${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(order['total_harga'])}",
                        style: tsBodySmallSemibold(black),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Status laundry",
                        style: tsLabelMediumMedium(black),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: statusColor.withOpacity(0.1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${order['status']}',
                          style: tsBodySmallSemibold(statusColor),
                        ),
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
}
