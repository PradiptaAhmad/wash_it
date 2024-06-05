import 'package:wash_it/presentation/chat_page/controllers/chat_controller.dart';
import 'package:wash_it/presentation/chat_page/widgets/chat_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wash_it/widget/common/box_shadow.dart';
import '../../infrastructure/theme/themes.dart';

class DetailMessageScreen extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              localMainShadow(),
            ]),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                ),
                SizedBox(width: 2),
                Image.asset(
                  "assets/img_chat/profile_chat.png",
                  fit: BoxFit.fill,
                  height: 45,
                  width: 45,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Smith Mathew",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.local_phone, color: Colors.black),
          ),
        ],
      ),
      body: ChatViewWidget(),
    );
  }
}
