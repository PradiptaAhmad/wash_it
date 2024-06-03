enum ChatMessageType { text, audio, image }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessageModel {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessageModel({
    this.text = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });
}

List<ChatMessageModel> demeChatMessages = [
  ChatMessageModel(
    text: "Assalamualaikum",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessageModel(
    text: "Waalaikumsalam",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessageModel(
    text: "Barang saya ada yang ketinggalan bu",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessageModel(
    text: "barang apa?",
    messageType: ChatMessageType.image,
    messageStatus: MessageStatus.viewed,
    isSender: true,
  ),
  ChatMessageModel(
    text: "Barang laundry?",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: true,
  ),
  ChatMessageModel(
    text: "Iya bu",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessageModel(
    text: "tunggu bentar ya",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
  ),
];
