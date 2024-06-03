import 'package:flutter/material.dart';

import '../../../infrastructure/theme/themes.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: lightGrey,
              width: screenWidth * 0.39,
              height: 2,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Atau",
              style: tsBodySmallMedium(darkGrey),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              color: lightGrey,
              width: screenWidth * 0.39,
              height: 2,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
