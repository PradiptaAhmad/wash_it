import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SliderPage extends StatelessWidget {
  final Widget titleWidget;
  final Widget bodyWidget;
  final String image;

  SliderPage({required this.titleWidget, required this.bodyWidget, required this.image});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Image.asset(
              image,
              width: width * 0.6,
            ),
          ),
          titleWidget,
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: bodyWidget,
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
