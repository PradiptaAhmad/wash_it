import 'package:flutter/material.dart';
import 'package:wash_it/presentation/status_page/widgets/status_categories_filter_pop_up.dart';
import 'package:wash_it/widget/common/categories_button_widget.dart';

import '../../infrastructure/theme/themes.dart';
import '../popup/custom_pop_up.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    required this.controller,
  });

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
            CategoriesButtonWidget(
              controller: controller,
              title: "Semua status",
              onTap: () => statusCategoriesFilterPopUp(context, controller),
            ),
            SizedBox(width: 5),
            CategoriesButtonWidget(
              controller: controller,
              title: "ambatron",
            ),
            SizedBox(width: 5),
            CategoriesButtonWidget(
              controller: controller,
              title: "ambatron",
            ),
          ],
        ),
      ),
    );
  }
}
