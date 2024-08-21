import 'package:flutter/material.dart';

import '../../../widgets/shimmer/shimmer_widget.dart';

class shimmerPreviewNewest extends StatelessWidget {
  const shimmerPreviewNewest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
        child: ShimmerWidget(
          width: double.infinity,
          height: 142,
          radius: 10,
        ),
      ),
    );
  }
}
