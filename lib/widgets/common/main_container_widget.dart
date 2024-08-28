import 'package:flutter/material.dart';
import '../../infrastructure/theme/themes.dart';

class MainContainerWidget extends StatelessWidget {
  const MainContainerWidget(
      {Key? key,
      this.childs,
      this.onPressed,
      this.color,
      this.height,
      this.width,
      this.border,
      this.padding,
      this.margin,
      this.borderRadius})
      : super(key: key);

  final Color? color;
  final border;
  final Widget? childs;
  final double? height, width;
  final void Function()? onPressed;
  final padding, margin;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          margin: margin,
          padding: padding,
          height: height?.toDouble(),
          width: width?.toDouble(),
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            // boxShadow: [localMainShadow()],
            border: border ??
                Border.all(color: lightGrey.withOpacity(0.5), width: 1),
          ),
          child: childs),
    );
  }
}
