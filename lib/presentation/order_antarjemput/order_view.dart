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
          OrderPageScreen1(
            onNext: () => _navigateToNextPage(),
          ),
          OrderPageScreen2(
            onNext: () => _navigateToNextPage(),
            onBack: () => _navigateToPreviousPage(),
          ),
          // OrderPageScreen3(onFinish: () => _finishProcess()),
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
    Navigator.of(context).pop();
  }
}
