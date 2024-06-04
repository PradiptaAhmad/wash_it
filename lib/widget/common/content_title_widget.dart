import 'package:flutter/material.dart';

import '../../infrastructure/theme/themes.dart';

class ContentTitleWidget extends StatelessWidget {
  const ContentTitleWidget(
      {Key? key,
      required this.title,
      this.subtitle,
      this.childs,
      this.lefttextSize,
      this.righttextSize})
      : super(key: key);

  final String? title, subtitle;
  final Widget? childs;

  final lefttextSize, righttextSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: defaultMargin),
      child: Row(
        children: [
          Expanded(
              child: Text(
            title ?? "",
            style: lefttextSize ?? tsBodyMediumSemibold(black),
          )),
          Text(
            subtitle ?? "",
            style: righttextSize ?? tsLabelLargeMedium(darkGrey),
          ),
          childs ?? SizedBox(),
        ],
      ),
    );
  }
}
