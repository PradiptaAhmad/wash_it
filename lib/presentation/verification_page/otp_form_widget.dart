import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';

// ignore: must_be_immutable
class PinFormInput extends StatelessWidget {
  PinFormInput({
    super.key,
    required this.controller,
  });

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 60,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headlineSmall,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              width: 2,
              color: lightGrey,
            ),
          ),
          focusColor: darkBlue,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: grey,
              )),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
