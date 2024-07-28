import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wash_it/infrastructure/theme/themes.dart';
import 'package:wash_it/widget/common/main_container_widget.dart';

class TransactionPageSkeleton extends StatelessWidget {
  const TransactionPageSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainContainerWidget(
              color: primaryColor,
              height: 80,
              width: double.infinity,
            ),
            SizedBox(height: 10),
            MainContainerWidget(
              color: primaryColor,
              height: 124,
              width: double.infinity,
            ),
            SizedBox(height: 10),
            MainContainerWidget(
              color: primaryColor,
              height: 146,
              width: double.infinity,
            ),
            SizedBox(height: 10),
            MainContainerWidget(
              color: primaryColor,
              height: 120,
              width: double.infinity,
            ),
            SizedBox(height: 10),
            MainContainerWidget(
              color: primaryColor,
              height: 120,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
