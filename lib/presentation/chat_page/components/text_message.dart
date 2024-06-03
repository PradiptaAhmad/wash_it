import 'package:flutter/material.dart';

import '../../../infrastructure/theme/themes.dart';
import '../models/chat_message.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({Key? key, required this.message}) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}