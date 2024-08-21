import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/themes.dart';
import '../controllers/status_page.controller.dart';

Future typeCategoriesFilterPopUp(
    BuildContext context, StatusPageController controller) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    builder: (context) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.16,
        ),
        child: Container(
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
                  Text("Filter konten status",
                      style: tsBodyMediumMedium(black)),
                ],
              ),
              SizedBox(height: 15),
              Obx(() => buildFilterOption(controller, "Antar Jemput", 6)),
              SizedBox(height: 10),
              Obx(() => buildFilterOption(controller, "Antar Mandiri", 7)),
            ],
          ),
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
      controller.typeSelectedFilterName.value = text;
      controller.applyFilter();
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
