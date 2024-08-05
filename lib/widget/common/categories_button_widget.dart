import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../infrastructure/theme/themes.dart';

class CategoriesButtonWidget extends StatelessWidget {
  const CategoriesButtonWidget(
      {Key? key, this.controller, this.title, this.onTap})
      : super(key: key);
  final controller;
  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(defaultMargin),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultMargin),
          border: Border.all(color: lightGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.toString(),
                style: tsBodySmallMedium(darkGrey),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: darkGrey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
