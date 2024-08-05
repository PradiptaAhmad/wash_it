import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: defaultMargin),
          InkWell(
            onTap: () {
              optionPopUp(context, controller);
            },
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
                      "Semua",
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
          ),
        ],
      ),
    );
  }
}
