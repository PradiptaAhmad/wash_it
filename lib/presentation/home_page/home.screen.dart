import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/home_page/shimmer/shimmer_preview_newest.dart';
import 'package:wash_it/widgets/common/main_container_widget.dart';
import 'package:wash_it/widgets/shimmer/shimmer_widget.dart';

import '../../widgets/common/content_title_widget.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: lightGrey.withOpacity(0.1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 95),
        child: _buildAppbar(),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.onRefresh(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Obx(() => !controller.isLoading.value
                    ? Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildOrderTypeWidget(
                                  mainTitle: "Antar Jemput",
                                  desc: "Pesan Laundry dan diantar langsung",
                                  onPressed: () {
                                    Get.toNamed(Routes.ORDERANTARJEMPUT_PAGE,
                                        arguments: 'antar_jemput');
                                  },
                                  color: Colors.orange,
                                  icon: Icons.delivery_dining_rounded),
                              SizedBox(width: 10),
                              _buildOrderTypeWidget(
                                  mainTitle: "Antar Mandiri",
                                  desc:
                                      "Pesan Laundry dan antar laundry sendiri",
                                  onPressed: () {
                                    Get.toNamed(Routes.ORDERANTARJEMPUT_PAGE,
                                        arguments: 'antar_mandiri');
                                  },
                                  color: Colors.green,
                                  icon: Icons.directions_walk_rounded)
                            ]))
                    : _shimmerOrderTypeWidget()),
                SizedBox(height: 20),
                Obx(
                  () => !controller.isLoading.value
                      ? ContentTitleWidget(
                          title: "PESANAN TERBARU",
                          lefttextSize: tsBodySmallSemibold(grey),
                        )
                      : _shimmerTitleWidget(),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return shimmerPreviewNewest();
                  }
                  if (controller.ordersList.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(60),
                      child: Center(
                        child: Text("Tidak ada pesanan",
                            style: tsBodyMediumMedium(darkGrey)),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.ordersList.length < 2
                        ? controller.ordersList.length
                        : 2,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final order = controller
                          .ordersList[controller.ordersList.length - 1 - index];
                      return _buildNewestPreviewWidget(order);
                    },
                  );
                }),
                SizedBox(height: 10),
                Obx(
                  () => !controller.isLoading.value
                      ? ContentTitleWidget(
                          title: "TIPE LAUNDRY",
                          lefttextSize: tsBodySmallSemibold(grey))
                      : _shimmerTitleWidget(),
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    children: List.generate(10, (index) {
                      return MainContainerWidget(
                        margin: const EdgeInsets.only(right: 10),
                        padding: EdgeInsets.all(15),
                        childs: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Cuci Kering",
                                style: tsBodyMediumMedium(black)),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _shimmerTitleWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
    child: ShimmerWidget(
      height: 20,
      radius: 8,
    ),
  );
}

Widget _shimmerOrderTypeWidget() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
    child: Row(
      children: [
        Expanded(child: ShimmerWidget(height: 141, radius: 10)),
        SizedBox(width: 10),
        Expanded(child: ShimmerWidget(height: 141, radius: 10)),
      ],
    ),
  );
}

Widget _buildAppbar() {
  return MainContainerWidget(
    color: primaryColor,
    borderRadius: 25,
    childs: Column(
      children: [
        SizedBox(height: 55.00),
        MainTitleWidget(),
        Divider(color: lightGrey.withOpacity(0.2), thickness: 2),
        InkWell(
          onTap: () => Get.toNamed(Routes.ADDRESS_PAGE),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              children: [
                Icon(Icons.location_on_rounded, color: Colors.red),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rumah",
                        style: tsLabelLargeSemibold(grey),
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          "Jl.Pala No. 1, Kec. Pala, Kab. Pala, Prov. Pala, 12345, awdawdwdawd",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tsBodySmallSemibold(black),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.keyboard_arrow_right_rounded, color: grey),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget _buildOrderTypeWidget(
    {required String mainTitle,
    required String desc,
    required Null Function() onPressed,
    required IconData icon,
    color}) {
  return Expanded(
    child: InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      child: MainContainerWidget(
        childs: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    icon,
                    color: color,
                    size: 35,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mainTitle,
                          style: tsBodyMediumSemibold(black),
                        ),
                        Text(desc, style: tsLabelLargeMedium(darkGrey)),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 20,
                    color: grey,
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

Widget _buildNewestPreviewWidget(order) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.TRANSACTION_PAGE,
              arguments: [order['id'], 'order']);
          print('object');
        },
        child: MainContainerWidget(
          childs: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 10,
            ),
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
                          "${order['no_pemesanan']}",
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
                            "Estimasi: ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(order['tanggal_estimasi'] ?? "2007-07-31 00:00:00"))}",
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
                          "${order['nama_pemesan']}",
                          style: tsBodySmallSemibold(black),
                        ),
                        Text(
                          order['jenis_pemesanan'] == 'antar_jemput'
                              ? "Antar Jemput"
                              : "Antar Mandiri",
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          order['berat_laundry'] == null
                              ? "Berat belum tercatat"
                              : "${order['berat_laundry']}",
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          "${order['nama_laundry']}",
                          style: tsBodySmallSemibold(successColor),
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
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class MainTitleWidget extends GetView<HomeController> {
  const MainTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 45,
                width: 45,
                child: Image.network(
                  controller.userData['image_path'] == null
                      ? 'https://ui-avatars.com/api/?name=${controller.userData['username']}&background=random&size=128'
                      : 'https://pradiptaahmad.tech/image/${controller.userData['image_path']}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Halo,",
                    style: tsBodyLargeMedium(darkGrey),
                  ),
                  Obx(() => ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 300),
                      child: Text(
                        controller.userData['username'] ?? "Anon",
                        style: tsBodyLargeSemibold(black),
                        overflow: TextOverflow.ellipsis,
                      ))),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.NOTIFICATION_PAGE);
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 45,
                width: 45,
                child: const Icon(
                  Icons.notifications,
                  color: darkGrey,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
