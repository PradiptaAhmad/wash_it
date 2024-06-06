import 'package:flutter/material.dart';

import '../../../infrastructure/theme/themes.dart';
import 'auth_text_field.dart';

class InputFormWidget extends StatelessWidget {
  const InputFormWidget({
    Key? key,
    this.title,
    this.hintText,
    this.validator,
    this.textField,
    this.keyboardType,
    this.onChanged,
    this.formatter,
  }) : super(key: key);
  final String? title, hintText;
  final validator, keyboardType, formatter;
  final Widget? textField;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: tsBodyMediumMedium(black),
          ),
          SizedBox(
            height: 12,
          ),
          textField ??
              AuthTextField(
                formatter: formatter,
                hintText: hintText ?? "",
                validator: validator,
                keyboardType: keyboardType,
                onChanged: onChanged,
              ),
        ],
      ),
    );
  }
}
