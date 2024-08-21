import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/presentation/history_page/controllers/history_page.controller.dart';

import '../../../infrastructure/theme/themes.dart';
import '../../../widgets/common/categories_button_widget.dart';

class HistoryFilterButton extends GetView<HistoryPageController> {
  const HistoryFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx(
          () => Row(
            children: [
              SizedBox(width: defaultMargin),
              CategoriesButtonWidget(
                onTap: () {
                  controller.isSelected.value = 0;
                  controller.applyFilter();
                },
                controller: controller,
                title: "Semua",
                trailing: false,
                isSelected: controller.isSelected.value == 0 ? true : false,
              ),
              CategoriesButtonWidget(
                onTap: () {
                  controller.isSelected.value = 1;
                  controller.applyFilter();
                },
                controller: controller,
                title: "Selesai",
                trailing: false,
                isSelected: controller.isSelected.value == 1 ? true : false,
              ),
              CategoriesButtonWidget(
                onTap: () {
                  controller.isSelected.value = 2;
                  controller.applyFilter();
                },
                controller: controller,
                title: "Dibatalkan",
                trailing: false,
                isSelected: controller.isSelected.value == 2 ? true : false,
              ),
              // CategoriesButtonWidget(
              //   onTap: () {},
              //   controller: controller,
              //   title: "Semua Tanggal",
              //   isSelected: false,
              // ),
              // CategoriesButtonWidget(
              //   onTap: () {},
              //   controller: controller,
              //   title: "Semua Jenis",
              //   isSelected: false,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
