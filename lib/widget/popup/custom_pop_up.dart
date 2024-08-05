import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/themes.dart';

Future reviewPopUp(context, controller) {
  return showModalBottomSheet(
    context: context,
    enableDrag: true,
    isDismissible: true,
    scrollControlDisabledMaxHeightRatio: 0.7,
    sheetAnimationStyle: AnimationStyle(
      duration: Durations.medium1,
      curve: Curves.easeInOut,
    ),
    backgroundColor: primaryColor,
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.close_rounded,
                  color: darkGrey,
                ),
              ),
            ),
            RatingBar.builder(
              itemPadding: EdgeInsets.symmetric(horizontal: 0),
              glow: false,
              itemSize: 60,
              itemBuilder: (context, _) => Icon(
                Icons.star_rate_rounded,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                controller.rating.value = rating;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(color: lightGrey, thickness: 1),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tulis ulasan kamu!",
                style: tsBodyMediumMedium(black),
              ),
            ),
            SizedBox(height: 5),
            ExtendedTextField(
              onChanged: (value) {
                controller.review.value = value;
              },
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Aku suka disko',
                hintStyle: tsBodySmallMedium(darkGrey),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: secondaryColor, width: 2)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: lightGrey, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: warningColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: primaryColor,
                filled: true,
              ),
            ),
            SizedBox(height: defaultMargin),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                child: Center(
                  child:
                      Text("Kirim", style: tsBodySmallSemibold(primaryColor)),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future optionPopUp(context, controller) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    scrollControlDisabledMaxHeightRatio: 0.11,
    sheetAnimationStyle: AnimationStyle(
      duration: Durations.medium1,
      curve: Curves.easeInOut,
    ),
    builder: (context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.close_rounded, color: black),
                SizedBox(width: 10),
                Text("Lainnya", style: tsBodyMediumMedium(black)),
              ],
            ),
            SizedBox(height: defaultMargin),
            InkWell(
              onTap: () {},
              splashColor: Colors.transparent,
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 28,
                child:
                    Text("Batalkan pesanan", style: tsBodySmallMedium(black)),
              ),
            )
          ],
        ),
      );
    },
  );
}
