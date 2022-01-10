class MessageModel {
  String senderId;
  String dateTime;
  String text;
  String receiverId;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.text,
    this.dateTime,

  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];

  }

  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'text': text,
      'dateTime': dateTime,

    };
  }
}
