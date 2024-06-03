import 'package:flutter/material.dart';
import 'package:wash_it/presentation/chat_page/components/text_message.dart';

import '../../../infrastructure/theme/themes.dart';
import '../models/chat_message.dart';

class Message extends StatelessWidget {
  const Message({Key? key, required this.message,}) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: Row(
        mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/img_chat/profile_chat.png"),
            ),
            SizedBox(width: defaultPadding / 2),
          ],
          TextMessage(message: message),
        ],
      ),
    );
  }
}