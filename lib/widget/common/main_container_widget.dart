import 'package:flutter/material.dart';
import '../../infrastructure/theme/themes.dart';

class MainContainerWidget extends StatelessWidget {
  const MainContainerWidget({
    Key? key,
    this.childs,
    this.onPressed,
    this.color,
    this.height,
    this.width,
    this.border,
    this.padding,
  }) : super(key: key);

  final Color? color;
  final border;
  final Widget? childs;
  final double? height, width;
  final void Function()? onPressed;
  final padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          padding: padding,
          height: height?.toDouble(),
          width: width?.toDouble(),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(20),
            // boxShadow: [localMainShadow()],
            border: Border.all(color: lightGrey, width: 1),
          ),
          child: childs),
    );
  }
}
