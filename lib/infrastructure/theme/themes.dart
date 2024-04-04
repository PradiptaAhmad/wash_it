import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

// Color Styles
const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFF76ABAE);
const Color darkGrey = Color(0xFF767676);
const Color black = Color(0xFF000000);
const Color grey = Color(0xFFB5B5B5);
const Color darkBlue = Color(0xFF535C6B);
const Color successColor = Color(0xFF23A56A);
const Color warningColor = Color(0xFFE72929);
const Color lightGrey = Color(0xFFDEDEDE);
const Color lightGreen = Color(0xFFE5F4ED);

// Category Color
const Color categoryCuciKering = Color(0xFFFFFDD7);
const Color categoryCuciSetrika = Color(0xFFEFBC9B);
const Color categoryCuciRegular = Color(0xFFD9EDBF);

// margin and padding
const double defaultMargin = 15.0;
const double defaultPadding = 24.0;

// Text Styles

// Headline Text Styles
// Large
TextStyle tsHeadlineLargeRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 28,
  );
}
TextStyle tsHeadlineLargeMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 28,
  );
}
TextStyle tsHeadlineLargeSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 28,
  );
}
TextStyle tsHeadlineLargeBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 28,
  );
}

// Medium 
TextStyle tsHeadlineMediumRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 26,
  );
}
TextStyle tsHeadlineMediumMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 26,
  );
}
TextStyle tsHeadlineMediumSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 26,
  );
}
TextStyle tsHeadlineMediumBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 26,
  );
}

// Small
TextStyle tsHeadlineSmallRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );
}
TextStyle tsHeadlineSmallMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );
}
TextStyle tsHeadlineSmallSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
}
TextStyle tsHeadlineSmallBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );
}

// Title Text Styles
// Large
TextStyle tsTitleLargeRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 22,
  );
}
TextStyle tsTitleLargeMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );
}
TextStyle tsTitleLargeSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );
}
TextStyle tsTitleLargeBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 22,
  );
}

// Medium
TextStyle tsTitleMediumRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );
}
TextStyle tsTitleMediumMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
}
TextStyle tsTitleMediumSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
}
TextStyle tsTitleMediumBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
}

// Small
TextStyle tsTitleSmallRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
}
TextStyle tsTitleSmallMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
}
TextStyle tsTitleSmallSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
}
TextStyle tsTitleSmallBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );
}

// Body Text Styles
// Large
TextStyle tsBodyLargeRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
}
TextStyle tsBodyLargeMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
}
TextStyle tsBodyLargeSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
}
TextStyle tsBodyLargeBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
}

// Medium
TextStyle tsBodyMediumRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
}
TextStyle tsBodyMediumMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}
TextStyle tsBodyMediumSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
}
TextStyle tsBodyMediumBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
}

// Small
TextStyle tsBodySmallRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
}
TextStyle tsBodySmallMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
}
TextStyle tsBodySmallSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
}
TextStyle tsBodySmallBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );
}

// Label Text Styles
// Large
TextStyle tsLabelLargeRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
}
TextStyle tsLabelLargeMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
}
TextStyle tsLabelLargeSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
}
TextStyle tsLabelLargeBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 10,
  );
}

// Medium
TextStyle tsLabelMediumRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 8,
  );
}
TextStyle tsLabelMediumMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 8,
  );
}
TextStyle tsLabelMediumSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 8,
  );
}
TextStyle tsLabelMediumBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 8,
  );
}

// Small
TextStyle tsLabelSmallRegular(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w400,
    fontSize: 6,
  );
}
TextStyle tsLabelSmallMedium(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: 6,
  );
}
TextStyle tsLabelSmallSemibold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w600,
    fontSize: 6,
  );
}
TextStyle tsLabelSmallBold(Color color) {
  return GoogleFonts.poppins(
    color: color,
    fontWeight: FontWeight.w700,
    fontSize: 6,
  );
}




