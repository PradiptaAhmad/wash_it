import 'package:flutter/material.dart';
import 'order_page_screen1.dart';
import 'order_page_screen2.dart';
import 'order_page_screen3.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final PageController _pageController = PageController(initialPage: 0);
  String nama = "";
  String nomorTelepon = "";
  String alamat = "";
  String tipeLaundry = "";
  String catatan = "";
  DateTime jadwalPengambilan = DateTime.now();
  double hargaPerKg = 0.0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          OrderPageScreen1(onNext: _navigateToNextPage, onFinish: _finishProcess),
          OrderPageScreen2(onNext: _navigateToNextPage, onBack: _navigateToPreviousPage),
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

  void _finishProcess() {
    // Add logic to handle finishing the order process
    // For example, show a confirmation dialog or navigate to a success page
  }
}
