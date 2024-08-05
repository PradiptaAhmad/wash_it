import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/presentation/status_page/widgets/status_categories_filter_pop_up.dart';

import '../../../infrastructure/theme/themes.dart';
import '../../../widget/common/categories_button_widget.dart';

class StatusCategoriesButtonWidget extends StatelessWidget {
  const StatusCategoriesButtonWidget({Key? key, required this.controller})
      : super(key: key);

  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: defaultMargin),
            Obx(() {
              if (controller.selectedFilter.value > 0) {
                return Row(
                  children: [
                    InkWell(
                      onTap: () => controller.selectedFilter.value = 0,
                      borderRadius: BorderRadius.circular(defaultMargin),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: lightGrey),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            Icons.close_rounded,
                            color: darkGrey,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                );
              } else {
                return SizedBox();
              }
            }),
            Obx(
              () => CategoriesButtonWidget(
                controller: controller,
                title: controller.selectedFilter.value == 0
                    ? "Semua status"
                    : controller.statusSelectedFilterName.value,
                onTap: () => statusCategoriesFilterPopUp(context, controller),
              ),
            ),
            SizedBox(width: 5),
            CategoriesButtonWidget(
              controller: controller,
              title: "Semua jenis",
            ),
            SizedBox(width: 5),
            CategoriesButtonWidget(
              controller: controller,
              title: "Semua tanggal",
            ),
          ],
        ),
      ),
    );
  }
}
