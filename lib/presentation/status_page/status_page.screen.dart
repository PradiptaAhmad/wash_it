import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/status_page.controller.dart';

class StatusPageScreen extends GetView<StatusPageController> {
  const StatusPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StatusPageScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StatusPageScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
