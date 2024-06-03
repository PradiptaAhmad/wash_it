import 'package:flutter/material.dart';

import '../../infrastructure/theme/themes.dart';
import 'box_shadow.dart';

class MainContainerWidget extends StatelessWidget {
  const MainContainerWidget(
      {Key? key,
      this.childs,
      this.onPressed,
      this.color,
      this.height,
      this.width})
      : super(key: key);

  final Color? color;
  final Widget? childs;
  final int? height, width;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: height?.toDouble(),
          width: width?.toDouble(),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [localMainShadow()],
          ),
          child: childs),
    );
  }
}
