import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Key? key;
  final Color? backgroundColor;
  final String? text;
  final Color? textColor;
  const ButtonWidget({
    this.onPressed,
    this.key,
    this.backgroundColor,
    this.text,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          text!,
          style: tsBodyMediumSemibold(textColor ?? primaryColor),
        ),
      ),
    );
  }
}
