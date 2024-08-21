import 'package:flutter/material.dart';

import '../../infrastructure/theme/themes.dart';

Future optionPopUp(context, controller) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    scrollControlDisabledMaxHeightRatio: 0.11,
    sheetAnimationStyle: AnimationStyle(
      duration: Durations.medium1,
      curve: Curves.easeInOut,
    ),
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.close_rounded, color: black),
                SizedBox(width: 10),
                Text("Lainnya", style: tsBodyMediumMedium(black)),
              ],
            ),
            SizedBox(height: defaultMargin),
            InkWell(
              onTap: () {},
              splashColor: Colors.transparent,
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 28,
                child:
                    Text("Batalkan pesanan", style: tsBodySmallMedium(black)),
              ),
            )
          ],
        ),
      );
    },
  );
}
