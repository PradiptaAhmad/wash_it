import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../widget/common/detail_widget.dart';
import 'controllers/order_page.controller.dart';
import 'order_page_screen1.dart';
import 'order_page_screen2.dart';
import 'order_page_screen3.dart';

class OrderView extends GetView<OrderAntarJemputController> {
  final PageController _pageController = PageController(initialPage: 0);

  String nama = "";
  String nomorTelepon = "";
  String alamat = "";
  String tipeLaundry = "";
  String catatan = "";
  DateTime jadwalPengambilan = DateTime.now();
  double hargaPerKg = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          OrderPageScreen1(
              onNext: _navigateToNextPage, onFinish: _finishProcess),
          OrderPageScreen2(
              onNext: _navigateToNextPage, onBack: _navigateToPreviousPage),
          OrderPageScreen3(
            onBack: _navigateToPreviousPage,
            onFinish: _finishProcess,
            nama: nama,
            nomorTelepon: nomorTelepon,
            alamat: alamat,
            tipeLaundry: tipeLaundry,
            catatan: catatan,
            jadwalPengambilan: jadwalPengambilan,
            hargaPerKg: hargaPerKg,
          ),
        ],
      ),
    );
  }

  void _navigateToNextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToPreviousPage() {
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _finishProcess() {}

  Widget buildOrderList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
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
        },
      );
    });
  }
}
