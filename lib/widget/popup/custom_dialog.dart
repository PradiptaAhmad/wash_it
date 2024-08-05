import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> exitConfirmationDialog(context, controller) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text(
            'Apakah Anda yakin ingin kembali ke halaman sebelumnya?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Batal'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
          TextButton(
            child: const Text('Ya'),
            onPressed: () {
              controller.currentStep.value = 0;
              Navigator.of(dialogContext).pop();
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
