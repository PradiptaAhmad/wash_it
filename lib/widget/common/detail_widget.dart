import 'package:flutter/material.dart';
import 'package:wash_it/widget/common/main_container_widget.dart';

import '../../infrastructure/theme/themes.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key,
    this.transcationNum,
    this.title,
    this.subTitle,
    this.bottomTitle,
    this.images,
    this.childs,
    this.onPressed,
    this.paddingValues,
  }) : super(key: key);

  final String? transcationNum, title, subTitle, bottomTitle, images;
  final Widget? childs;
  final void Function()? onPressed;
  final double? paddingValues;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: defaultMargin),
      child: InkWell(
        onTap: onPressed,
        child: MainContainerWidget(
          childs: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transcationNum ?? "Null",
                  style: tsLabelLargeRegular(darkGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 60,
                        width: 60,
                        child: Padding(
                          padding: EdgeInsets.all(paddingValues ?? 0.0),
                          child: Image.asset(
                            images ?? "assets/img_home/default.png",
                            fit: BoxFit.cover,
                          ),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? "Null",
                          style: tsBodySmallSemibold(black),
                        ),
                        Text(
                          subTitle ?? "Null",
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          bottomTitle ?? "Null",
                          style: tsLabelLargeBold(successColor),
                        )
                      ],
                    )
                  ],
                ),
                childs ?? SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
