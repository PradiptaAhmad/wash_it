import 'package:flutter/material.dart';

import '../../infrastructure/theme/themes.dart';

class ContentTitleWidget extends StatelessWidget {
  const ContentTitleWidget(
      {Key? key, required this.title, this.subtitle, this.childs})
      : super(key: key);

  final String? title, subtitle;
  final Widget? childs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: defaultMargin),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title ?? "",
            style: tsBodyMediumSemibold(black),
          )),
          Text(
            subtitle ?? "",
            style: tsLabelLargeMedium(darkGrey),
          ),
          childs ?? SizedBox(),
        ],
      ),
    );
  }
}
