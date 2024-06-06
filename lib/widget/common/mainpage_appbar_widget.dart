import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../infrastructure/theme/themes.dart';

class MainpageAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const MainpageAppbarWidget({
    Key? key,
    this.onPressed,
    this.title,
    this.icon,
    this.color,
    this.textStyle,
    this.noLeading = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? title;
  final IconData? icon;
  final Color? color;
  final TextStyle? textStyle;
  final bool noLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: noLeading
          ? null
          : IconButton(
              icon: Icon(
                icon ?? Iconsax.arrow_left_2,
              ),
              onPressed: onPressed ?? Get.back,
            ),
      automaticallyImplyLeading: !noLeading,
      backgroundColor: primaryColor,
      title: Text(
        title ?? 'default text title',
        style: textStyle ?? tsBodyLargeMedium(black),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
