import 'package:flutter/material.dart';
import '../../../infrastructure/theme/themes.dart';
import '../models/chat_message_model.dart';
import 'package:wash_it/presentation/chat_page/widgets/message_widget.dart';

class ChatViewWidget extends StatelessWidget {
  const ChatViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) => MessageWidget(
                message: demeChatMessages[index],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 20,
                color: black.withOpacity(0.08),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Icon(Icons.mic, color: darkBlue),
                SizedBox(width: 20.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0 * 0.75,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: defaultPadding / 4),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Kirim Pesanan",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.attach_file,
                          color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.80),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
