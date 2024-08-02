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
        child: Padding(
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
        ),
      );
    },
  );
}
// Future reviewPopUp(context, controller) {
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     barrierColor: Colors.black.withOpacity(0.5),
//     sheetAnimationStyle: AnimationStyle(
//       duration: Durations.medium1,
//       curve: Curves.easeInOut,
//     ),
//     builder: (context) {
//       return GestureDetector(
//         onTap: () {},
//         child: DraggableScrollableSheet(
//           initialChildSize: 0.7,
//           minChildSize: 0.25,
//           maxChildSize: 1,
//           expand: true,
//           builder: (context, scrollController) {
//             return Container(
//               color: primaryColor,
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.all(defaultMargin),
//                   child: Column(
//                     children: [],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     },
//   );
// }
//
