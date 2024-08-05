import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController customSnackBar(title, message, color, textColor) {
  return Get.snackbar(
    title,
    message,
    backgroundColor: color,
    colorText: textColor,
  );
}

SnackbarController isNotEmptySnackBar() {
  return Get.snackbar(
    "Peringatan",
    "Data tidak boleh kosong",
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}
