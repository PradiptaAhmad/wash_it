import 'package:flutter/material.dart';

import '../../infrastructure/theme/themes.dart';
import 'auth_text_field.dart';

class InputFormWidget extends StatelessWidget {
  const InputFormWidget(
      {Key? key,
      required this.title,
      required this.hintText,
      this.validator,
      this.textField})
      : super(key: key);
  final String? title, hintText;
  final validator;
  final Widget? textField;

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
              AuthTextField(hintText: hintText ?? "", validator: validator),
        ],
      ),
    );
  }
}
