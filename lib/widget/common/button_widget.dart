import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Key? key;
  final Color? backgroundColor;
  final String? text;
  final Color? textColor;
  final Widget? child;

  const ButtonWidget({
    this.onPressed,
    this.key,
    this.backgroundColor,
    this.text,
    this.textColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: child
      ),
    );
  }
}
