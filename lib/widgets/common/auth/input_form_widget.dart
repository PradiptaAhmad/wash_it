import 'package:flutter/material.dart';

import '../../../infrastructure/theme/themes.dart';
import 'auth_text_field.dart';

class InputFormWidget extends StatelessWidget {
  const InputFormWidget({
    Key? key,
    this.formKey,
    this.title,
    this.hintText,
    this.validator,
    this.textField,
    this.keyboardType,
    this.onChanged,
    this.formatter,
    this.readOnly,
    this.controller,
  }) : super(key: key);
  final String? title, hintText;
  final validator, keyboardType, formatter;
  final Widget? textField;
  final Function(String)? onChanged;
  final bool? readOnly;
  final TextEditingController? controller;
  final Key? formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: tsBodySmallMedium(black),
          ),
          SizedBox(
            height: 12,
          ),
          textField ??
              AuthTextField(
                formKey: formKey,
                readOnly: readOnly,
                controller: controller,
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
