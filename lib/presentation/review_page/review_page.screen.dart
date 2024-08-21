import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wash_it/widgets/common/button_widget.dart';

import '../../infrastructure/theme/themes.dart';
import 'controllers/review_page.controller.dart';

class ReviewPageScreen extends GetView<ReviewPageController> {
  const ReviewPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Iconsax.arrow_left_2,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: primaryColor,
          title: Text("Beri Penilaian", style: tsBodyLargeMedium(black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.all(defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: RatingBar.builder(
                      itemPadding: EdgeInsets.symmetric(horizontal: 8),
                      glow: false,
                      itemSize: 40,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("Deskripsi", style: tsBodyMediumMedium(black)),
                      SizedBox(
                        width: 8,
                      ),
                      Text("(opsional)", style: tsBodySmallRegular(darkBlue))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Deskripsikan penilaianmu",
                      hintStyle: tsBodySmallRegular(darkGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    backgroundColor: secondaryColor,
                    child: Text(
                      "Beri Penilaian",
                      style: tsBodySmallMedium(primaryColor),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
