import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../../../infrastructure/theme/themes.dart';

class SearchDropdownWidget extends StatelessWidget {
  final Key? key;
  final Key? formKey;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;
  final void Function()? onTap;
  final double? height;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<SearchFieldListItem<dynamic>>? suggestions;
  final EdgeInsetsGeometry? padding;
  SearchDropdownWidget({
    this.key,
    this.hintText,
    this.contentPadding,
    this.width,
    this.formKey,
    this.validator,
    this.height,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.suggestions,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SearchField(
        suggestionStyle: tsBodySmallRegular(black),
        onSubmit: onSaved,
        onTap: onTap,
        onSaved: onSaved,
        validator: validator,
        searchInputDecoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: tsBodySmallMedium(darkGrey),
          fillColor: primaryColor,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor, width: 2),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: lightGrey, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
              borderSide: formKey != null &&
                      (formKey as GlobalKey<FormState>)
                              .currentState
                              ?.validate() ==
                          true
                  ? BorderSide.none
                  : BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(10)),
        ),
        suggestionsDecoration: SuggestionDecoration(
          color: primaryColor,
          padding: padding ?? EdgeInsets.zero,
        ),
        suggestionItemDecoration:
            BoxDecoration(border: Border(bottom: BorderSide.none)),
        suggestions: suggestions!,
      ),
    );
  }
}
