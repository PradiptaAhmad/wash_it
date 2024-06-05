import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/navigation/routes.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/content_title_widget.dart';
import 'package:wash_it/widget/common/detail_widget.dart';
import 'package:wash_it/widget/common/main_container_widget.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainWelcomeTitle(
              userName: "Bapak Bajuri",
            ),
            Container(
              padding: EdgeInsets.only(top: defaultMargin),
              child: Row(
                children: [
                  Expanded(
                      child: MainChoiceWidget(
                    onPressed: () {
                      Get.toNamed(Routes.ORDERANTARJEMPUT_PAGE);
                    },
                    imageAssets: 'assets/img_home/delivery1.png',
                    mainTitle: 'Antar Jemput',
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: MainChoiceWidget(
                    onPressed: () {
                      Get.toNamed(Routes.ORDERANTARJEMPUT_PAGE);
                    },
                    imageAssets: 'assets/img_home/delivery2.png',
                    mainTitle: 'Antar Mandiri',
                  )),
                ],
              ),
            ),
            ContentTitleWidget(
                title: "Sedang Berlangsung", subtitle: "Lihat Selengkapnya"),
            Obx(() {
              if (controller.isLoading.value) {
                return Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (controller.ordersList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Center(
                      child: Text(
                    'Order Tidak Bisa Ditemukan',
                    style: tsBodySmallMedium(black),
                  )),
                );
              }
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.ordersList.length,
                  itemBuilder: (context, index) {
                    final order = controller.ordersList[index];
                    return DetailWidget(
                      onPressed: () {
                        Get.toNamed(Routes.TRANSACTION_PAGE);
                      },
                      paddingValues: 10,
                      transcationNum: order.noPemesanan ?? "",
                      title: 'Cuci Setrika - ${order.namaPemesan}',
                      subTitle: 'Berat - ${order.beratLaundry}Kg',
                      bottomTitle: 'Rp. ${order.totalHarga}',
                    );
                  });
            }),
            ContentTitleWidget(
                title: "Riwayat Transaksi", subtitle: "Lihat Selengkapnya"),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: visualData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = visualData[index];
                return DetailWidget(
                  onPressed: () {
                    Get.toNamed(Routes.TRANSACTION_PAGE);
                  },
                  transcationNum: data['transcationNum'],
                  title: data['title'],
                  subTitle: data['subTitle'],
                  bottomTitle: data['bottomTitle'],
                  images: data['images'],
                  paddingValues: 10,
                  childs: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "23 Maret 2024",
                          style: tsLabelLargeRegular(black),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: successColor,
                          ),
                          height: 30,
                          width: 80,
                          child: Expanded(
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
            )
          ],
        ),
      ),
    )));
  }
}

class MainWelcomeTitle extends StatelessWidget {
  const MainWelcomeTitle({
    this.userName,
    super.key,
  });

  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Selamat Datang", style: tsLabelLargeSemibold(darkGrey)),
            Text(userName ?? "Anon", style: tsTitleMediumSemibold(black)),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: grey,
          ),
          height: 45,
          width: 45,
          child: const Icon(
            Icons.person,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}

Widget MainChoiceWidget({required imageAssets, required mainTitle, onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: MainContainerWidget(
      height: 110,
      childs: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageAssets),
                fit: BoxFit.cover,
              ),
            ),
            height: 50,
            width: 50,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            mainTitle,
            style: tsBodySmallSemibold(black),
          )
        ],
      ),
    ),
  );
}

final List<Map<String, dynamic>> visualData = [
  {
    'transcationNum': "No. Transaksi - 00414519797419",
    'title': "Cuci Setrika - Marlen",
    'subTitle': "Berat - 5Kg",
    'bottomTitle': "Rp. 25.000",
    'images': 'assets/img_home/delivery1.png',
  },
  {
    'transcationNum': "No. Transaksi - 00414519797419",
    'title': "Cuci Setrika - Bawwaz",
    'subTitle': "Berat - 5Kg",
    'bottomTitle': "Rp. 25.000",
    'images': 'assets/img_home/delivery2.png',
  },
];
