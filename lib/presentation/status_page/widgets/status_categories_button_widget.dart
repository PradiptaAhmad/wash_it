import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/presentation/status_page/controllers/status_page.controller.dart';
import 'package:wash_it/presentation/status_page/widgets/status_categories_filter_pop_up.dart';
import 'package:wash_it/presentation/status_page/widgets/type_categories_filter_pop_up.dart';

import '../../../infrastructure/theme/themes.dart';
import '../../../widgets/common/categories_button_widget.dart';

class StatusCategoriesButtonWidget extends GetView<StatusPageController> {
  const StatusCategoriesButtonWidget({Key? key}) : super(key: key);

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
                return Row(children: [
                  InkWell(
                      onTap: () {
                        controller.selectedFilter.value = 0;
                        controller.onRefresh();
                      },
                      borderRadius: BorderRadius.circular(defaultMargin),
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: lightGrey.withOpacity(0.5)),
                          ),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(
                                Icons.close_rounded,
                                color: grey,
                                size: 18,
                              )))),
                  SizedBox(width: 5)
                ]);
              }
              return Container();
            }),
            Obx(() => Visibility(
                  visible: !(controller.selectedFilter.value > 5 &&
                          controller.selectedFilter.value <= 7
                      ? true
                      : false),
                  child: CategoriesButtonWidget(
                    isSelected: controller.selectedFilter.value > 0 &&
                            controller.selectedFilter.value <= 5
                        ? true
                        : false,
                    controller: controller,
                    title: controller.selectedFilter.value == 0
                        ? "Semua status"
                        : controller.statusSelectedFilterName.value,
                    onTap: () =>
                        statusCategoriesFilterPopUp(context, controller),
                  ),
                )),
            Obx(() => Visibility(
                visible: !(controller.selectedFilter.value > 0 &&
                        controller.selectedFilter.value <= 5
                    ? true
                    : false),
                child: CategoriesButtonWidget(
                  isSelected: controller.selectedFilter.value > 5 &&
                          controller.selectedFilter.value <= 7
                      ? true
                      : false,
                  onTap: () => typeCategoriesFilterPopUp(context, controller),
                  controller: controller,
                  title: controller.selectedFilter.value == 0
                      ? "Semua jenis"
                      : controller.typeSelectedFilterName.value,
                ))),
          ],
        ),
      ),
    );
  }
}
