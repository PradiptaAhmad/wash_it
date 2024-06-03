import 'package:flutter/material.dart';
import '../../../infrastructure/theme/themes.dart';
import '../models/chat_message_model.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key, required this.message,}) : super(key: key);

  final ChatMessageModel message;

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
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 0.50,
                vertical: defaultPadding / 2
            ),
            decoration: BoxDecoration(
                color: secondaryColor.withOpacity(message.isSender ? 1 : 0.1),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: message.isSender
                    ? primaryColor
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
