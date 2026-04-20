class ChatMessageModel {
  final String text;
  final String senderId;
  final DateTime time;

  ChatMessageModel({
    required this.text,
    required this.senderId,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      "text": text,
      "senderId": senderId,
      "timestamp": time,
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      text: map["text"] ?? "",
      senderId: map["senderId"] ?? "",
      time: (map["timestamp"] as dynamic)?.toDate() ?? DateTime.now(),
    );
  }
}
