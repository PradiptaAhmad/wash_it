import 'package:flutter/material.dart';

class PreviewDetailPage extends StatelessWidget {
  const PreviewDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          height: 116,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
