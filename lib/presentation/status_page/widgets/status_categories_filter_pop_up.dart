import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/presentation/status_page/controllers/status_page.controller.dart';

import '../../../infrastructure/theme/themes.dart';

Future statusCategoriesFilterPopUp(context, StatusPageController controller) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close_rounded, color: black),
                ),
                SizedBox(width: 10),
                Text("Filter konten status", style: tsBodyMediumMedium(black)),
              ],
            ),
            SizedBox(height: 20),
            Obx(() => buildFilterOption(controller, "Baru Dibuat", 1)),
            SizedBox(height: 10),
            Obx(() => buildFilterOption(controller, "Menunggu Penjemputan", 2)),
            SizedBox(height: 10),
            Obx(() => buildFilterOption(controller, "Sedang Diproses", 3)),
            SizedBox(height: 10),
            Obx(() => buildFilterOption(controller, "Belum Dibayar", 4)),
            SizedBox(height: 10),
            Obx(() => buildFilterOption(controller, "Selesai", 5)),
          ],
        ),
      );
    },
  );
}

Widget buildFilterOption(
    StatusPageController controller, String text, int index) {
  return InkWell(
    onTap: () {
      controller.selectedFilter.value = index;
      controller.statusSelectedFilterName.value = text;
      controller.applyFilter('refresh');
      Get.back();
    },
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: tsBodySmallMedium(black)),
          circleRadioButton(
            selected: controller.selectedFilter.value == index,
          ),
        ],
      ),
    ),
  );
}

class circleRadioButton extends StatelessWidget {
  const circleRadioButton({
    Key? key,
    required this.selected,
  }) : super(key: key);

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              border:
                  Border.all(color: selected ? secondaryColor : grey, width: 2),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: selected ? secondaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }
}
