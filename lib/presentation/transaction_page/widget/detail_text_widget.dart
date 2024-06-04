import 'package:flutter/material.dart';

import '../../../infrastructure/theme/themes.dart';

class DetailDataWidget extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;

  const DetailDataWidget({
    required this.leftTitle,
    required this.rightTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leftTitle,
                style: tsBodySmallRegular(darkBlue),
                textAlign: TextAlign.left,
              ),
              Text(
                rightTitle,
                style: tsBodySmallRegular(darkBlue),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
