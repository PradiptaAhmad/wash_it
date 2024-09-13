import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../../../infrastructure/theme/themes.dart';

class SearchDropdownWidget extends StatelessWidget {
  final Key? key;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;
  final void Function()? onTap;
  final double? height;
  final void Function(String?)? onSuggestionSelected;
  final String? Function(String?)? validator;
  final List<SearchFieldListItem<dynamic>>? suggestions;
  final EdgeInsetsGeometry? padding;
  final bool? readOnly;
  final TextEditingController? controller;

  SearchDropdownWidget({
    this.key,
    this.hintText,
    this.contentPadding,
    this.width,
    this.validator,
    this.height,
    this.onSuggestionSelected,
    this.onTap,
    this.suggestions,
    this.padding,
    this.readOnly,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SearchField(
        readOnly: readOnly ?? false,
        controller: controller,
        suggestionStyle: tsBodySmallMedium(black),
        onTap: onTap,
        onSuggestionTap: (suggestion) {
          if (onSuggestionSelected != null) {
            onSuggestionSelected!(suggestion.searchKey);
          }
        },
        validator: validator,
        searchInputDecoration: SearchInputDecoration(
          searchStyle: tsBodySmallMedium(black),
          isDense: true,
          hintText: hintText,
          hintStyle: tsBodySmallMedium(darkGrey),
          fillColor: primaryColor,
          filled: true,
          contentPadding: contentPadding ?? EdgeInsets.all(defaultMargin),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: lightGrey, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        suggestionsDecoration: SuggestionDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          padding: padding ?? EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        ),
        suggestionItemDecoration: BoxDecoration(
          border: Border(bottom: BorderSide.none),
        ),
        suggestions: suggestions ?? [],
      ),
    );
  }
}
