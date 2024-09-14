import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/theme/themes.dart';
import 'controllers/chat_page.controller.dart';

class ChatPageScreen extends GetView<ChatPageController> {
  ChatPageScreen({super.key});

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: grey,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: primaryColor,
        elevation: 1,
        scrolledUnderElevation: 1,
        shadowColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: grey,
              backgroundImage: NetworkImage(controller
                          .userDetailData['image_path'] ==
                      null
                  ? 'https://ui-avatars.com/api/?name=PemilikLaundry&background=random&size=128'
                  : 'https://api.laundrynaruto.my.id/image/${controller.userDetailData['image_path']}'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pemilik Laundry', style: tsBodyLargeMedium(black)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: grey,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: controller.channel!.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CupertinoActivityIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error loading messages'));
                }
                // if (!snapshot.hasData) {
                //   return Center(child: Text('No messages available'));
                // }
                // if (!snapshot.hasData || controller.messagesData.isEmpty) {
                //   return Center(
                //       child: ElevatedButton(
                //           onPressed: () => print(snapshot.data),
                //           child: Text("data")));
                // }
                if (snapshot.hasData) {
                  var data = jsonDecode(snapshot.data);
                  if (data['event'] == 'MessageSent') {
                    var messageDetails = jsonDecode(data['data']);
                    controller.messagesData.insert(0, {
                      'from_user_id': messageDetails['from_user_id'],
                      'to_user_id': messageDetails['to_user_id'],
                      'message': messageDetails['message'],
                      'created_at': messageDetails['created_at'],
                    });
                  }
                }
                return Obx(
                  () => ListView.builder(
                    reverse: true,
                    controller: controller.scrollController,
                    itemCount: controller.messagesData.length,
                    itemBuilder: (context, index) {
                      var messageTile = controller.messagesData[index];
                      return ListTile(
                        title: Align(
                          alignment: messageTile['from_user_id'] == 'admin'
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: messageTile['from_user_id'] == 'admin'
                                  ? lightGrey
                                  : Colors.blue[100],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  messageTile['from_user_id'] == 'admin'
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${messageTile['message']}",
                                  style: tsBodySmallMedium(black),
                                ),
                                Text(
                                  "${DateFormat('HH:mm', 'id_ID').format(DateTime.parse(messageTile['created_at'] ?? "1443-07-31 00:00:00").toUtc().add(Duration(hours: 7)))}",
                                  style: tsLabelLargeMedium(darkGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: primaryColor,
                border: Border(top: BorderSide(color: lightGrey, width: 01))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textController,
                      style: tsBodySmallMedium(black),
                      decoration: InputDecoration(
                        hintStyle: tsBodySmallMedium(darkGrey),
                        hintText: 'Type a message...',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: secondaryColor, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: lightGrey, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: warningColor, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 20,
                      color: darkGrey,
                    ),
                    onPressed: () {
                      controller.addMessage(_textController.text);
                      _textController.clear();
                    },
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
