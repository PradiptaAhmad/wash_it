import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/history_page.controller.dart';

class HistoryPageScreen extends GetView<HistoryPageController> {
  const HistoryPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HistoryPageScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HistoryPageScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
