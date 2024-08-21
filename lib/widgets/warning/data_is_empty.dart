import 'package:flutter/cupertino.dart';

import '../../infrastructure/theme/themes.dart';

Widget DataIsEmpty(description) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Ooops!",
          style: tsHeadlineSmallMedium(darkGrey),
        ),
        Text(
          description,
          style: tsLabelLargeSemibold(grey),
        ),
      ],
    ),
  );
}
