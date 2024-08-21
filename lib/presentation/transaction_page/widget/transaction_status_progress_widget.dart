import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/presentation/transaction_page/controllers/transaction_page.controller.dart';

import '../../../infrastructure/theme/themes.dart';

class TransactionStatusProgressWidget
    extends GetView<TransactionPageController> {
  const TransactionStatusProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: 0,
            end: controller.statusList['status_code'] / 5,
          ),
          duration: Duration(seconds: 2),
          builder: (context, value, child) {
            return ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  stops: [value, value],
                  colors: [successColor, lightGrey],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(rect);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildIcon(Iconsax.receipt),
                  buildDottedLine(),
                  buildIcon(Iconsax.wallet_1),
                  buildDottedLine(),
                  buildIcon(Iconsax.bubble),
                  buildDottedLine(),
                  buildIcon(Iconsax.location),
                  buildDottedLine(),
                  buildIcon(Iconsax.verify),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 10),
        Text(
          "${controller.statusList['status_description']}",
          style: tsBodySmallMedium(black),
        ),
      ],
    );
  }

  Widget buildIcon(IconData icon) {
    return Icon(
      icon,
      size: 30,
      color: lightGrey,
    );
  }

  Widget buildDottedLine() {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: 40,
      lineThickness: 2,
      dashLength: 5,
      dashColor: lightGrey,
    );
  }
}
