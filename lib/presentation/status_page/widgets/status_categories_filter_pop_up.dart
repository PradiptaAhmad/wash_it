import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/themes.dart';

Future statusCategoriesFilterPopUp(context, controller) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    scrollControlDisabledMaxHeightRatio: 0.35,
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: defaultMargin),
            Obx(() => buildFilterOption(controller, "Semua status", 0)),
            SizedBox(height: defaultMargin),
            Obx(() => buildFilterOption(controller, "Baru dibuat", 1)),
            SizedBox(height: defaultMargin),
            Obx(() => buildFilterOption(controller, "Menunggu konfirmasi", 2)),
            SizedBox(height: defaultMargin),
            Obx(() => buildFilterOption(controller, "Sedang diproses", 3)),
            SizedBox(height: defaultMargin),
            Obx(() => buildFilterOption(controller, "Belum dibayar", 4)),
            SizedBox(height: defaultMargin),
            Obx(() => buildFilterOption(controller, "Selesai", 5)),
          ],
        ),
      );
    },
  );
}

Widget buildFilterOption(controller, String text, int index) {
  return InkWell(
    onTap: () {
      controller.selectedFilter.value = index;
      controller.statusSelectedFilterName.value = text;
      print(controller.statusSelectedFilterName.value);
      Get.back();
    },
    splashColor: Colors.transparent,
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
