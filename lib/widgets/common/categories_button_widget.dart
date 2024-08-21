import 'package:flutter/material.dart';

import '../../infrastructure/theme/themes.dart';

class CategoriesButtonWidget extends StatelessWidget {
  const CategoriesButtonWidget({
    Key? key,
    this.controller,
    this.title,
    this.onTap,
    this.trailing,
    required this.isSelected,
  }) : super(key: key);
  final controller;
  final String? title;
  final void Function()? onTap;
  final bool? trailing;
  final isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(defaultMargin),
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isSelected ? secondaryColor : lightGrey.withOpacity(0.5),
              width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title.toString(),
              style: tsBodySmallMedium(isSelected ? secondaryColor : grey),
            ),
            Visibility(
              visible: trailing ?? true,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: isSelected ? secondaryColor : grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
