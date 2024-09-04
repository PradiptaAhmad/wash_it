import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/presentation/history_page/controllers/history_page.controller.dart';

class HistoryReviewPopup extends GetView<HistoryPageController> {
  final int id;
  HistoryReviewPopup({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjust height based on content
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
                controller.reviewStar.value = rating;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(color: lightGrey, thickness: 1),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tulis Ulasan Kamu",
                style: tsBodyMediumMedium(black),
              ),
            ),
            SizedBox(height: 5),
            ExtendedTextField(
              onChanged: (value) {
                controller.reviewDesc.value = value;
              },
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Saya puas dengan layanan ini!',
                hintStyle: tsBodySmallRegular(darkGrey),
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
              onTap: () => controller.postReview(id),
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
  }
}
