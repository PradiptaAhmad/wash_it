import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../infrastructure/theme/themes.dart';

class OnGoingWidget extends StatelessWidget {
  const OnGoingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Iconsax.receipt,
                size: 30,
                color: successColor,
              ),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: 40,
                lineThickness: 2,
                dashLength: 5,
                dashColor: successColor,
              ),
              Icon(
                Iconsax.wallet_1,
                size: 30,
                color: successColor,
              ),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: 40,
                lineThickness: 2,
                dashLength: 5,
                dashColor: successColor,
              ),
              Icon(
                Iconsax.bubble,
                size: 30,
                color: successColor,
              ),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: 40,
                lineThickness: 2,
                dashLength: 5,
                dashColor: successColor,
              ),
              Icon(
                Iconsax.location,
                size: 30,
                color: successColor,
              ),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: 40,
                lineThickness: 2,
                dashLength: 5,
                dashColor: successColor,
              ),
              Icon(
                Iconsax.verify,
                size: 30,
                color: successColor,
              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("23/03", style: tsBodySmallRegular(black)),
                Text("Est.", style: tsBodySmallRegular(black)),
                Text("25/03", style: tsBodySmallRegular(black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
